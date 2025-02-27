//
//  ImageProcessor.swift
//  NailDiseaseSDK
//
//  Created by Piumal Kumara on 2025-02-27.
//


//
//  TFLiteImageProcessor.swift
//  NailDiseaseSDK
//
//  Created by Piumal Kumara on 2025-02-12.
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
}

