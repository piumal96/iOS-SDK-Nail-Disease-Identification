//
//  ImageProcessor.swift
//  NailDiseaseSDK
//
//  Created by Piumal Kumara on 2025-02-27.
//

import UIKit
import Foundation

public class TFLiteImageProcessor {
    
    /// Resize an image to the specified size.
    public static func resize(_ image: UIImage, to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
        /// Convert a UIImage to a pixel buffer (Data).
        public static func convertToBuffer(_ image: UIImage) -> Data? {
            guard let cgImage = image.cgImage else { return nil }

            let width = cgImage.width
            let height = cgImage.height
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bytesPerPixel = 4
            let bytesPerRow = bytesPerPixel * width
            let bitsPerComponent = 8

            var pixelData = [UInt8](repeating: 0, count: Int(width * height * bytesPerPixel))

            guard let context = CGContext(
                data: &pixelData,
                width: width,
                height: height,
                bitsPerComponent: bitsPerComponent,
                bytesPerRow: bytesPerRow,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else {
                print(" ERROR: Failed to create CGContext")
                return nil
            }

            context.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: width, height: height)))

            // Convert to RGB-only data (drop alpha channel)
            let rgbData = pixelData.enumerated().compactMap { index, byte -> UInt8? in
                let pixelIndex = index % bytesPerPixel
                return pixelIndex < 3 ? byte : nil
            }

            return Data(rgbData)
        }
}

