//
//  CameraViewController.swift
//  InterviewApp
//
//  Created by Andy Korshie-Sherrie on 31/10/2024.
//

import Foundation
import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate{
    private let captureSession = AVCaptureSession()
        private var photoOutput = AVCapturePhotoOutput()
        private let previewLayer = AVCaptureVideoPreviewLayer()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black
            setupCamera()
            setupCaptureButton()
        }
        
        private func setupCamera() {
            captureSession.sessionPreset = .photo
            guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
            guard let input = try? AVCaptureDeviceInput(device: camera) else { return }
            
            captureSession.addInput(input)
            captureSession.addOutput(photoOutput)
            
            previewLayer.session = captureSession
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
            
            captureSession.startRunning()
        }
        
        private func setupCaptureButton() {
            let button = UIButton(frame: CGRect(x: (view.frame.width - 80) / 2, y: view.frame.height - 100, width: 80, height: 50))
            button.setTitle("Capture", for: .normal)
            button.backgroundColor = .red
            button.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
            view.addSubview(button)
        }
        
        @objc private func capturePhoto() {
            let settings = AVCapturePhotoSettings()
            photoOutput.capturePhoto(with: settings, delegate: self)
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let imageData = photo.fileDataRepresentation() {
                let image = UIImage(data: imageData)
                let processedImage = ImageProcessingManager.applyGrayscaleFilter(to: image)
                showCapturedImage(processedImage)
            }
        }
        
        private func showCapturedImage(_ image: UIImage?) {
            let imageView = UIImageView(image: image)
            imageView.frame = view.bounds
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
        }
    }
