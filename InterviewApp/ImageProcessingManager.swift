//
//  ImageProcessingManager.swift
//  InterviewApp
//
//  Created by Andy Korshie-Sherrie on 31/10/2024.
//

import UIKit
import CoreImage

class ImageProcessingManager {
    static func applyGrayscaleFilter(to image: UIImage?) -> UIImage? {
           guard let inputImage = image, let ciImage = CIImage(image: inputImage) else { return nil }
           let filter = CIFilter(name: "CIPhotoEffectMono")
           filter?.setValue(ciImage, forKey: kCIInputImageKey)
           
           if let outputCIImage = filter?.outputImage,
              let cgImage = CIContext().createCGImage(outputCIImage, from: outputCIImage.extent) {
               return UIImage(cgImage: cgImage)
           }
           return nil
       }
}
