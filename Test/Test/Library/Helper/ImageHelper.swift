//
//  ImageHelper.swift
//  LuckyDraw
//
//  Created by S-Planet iOS on 6/1/2560 BE.
//  Copyright © 2560 S-Planet. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class ImageHelper: NSObject {
    
    static func imageWithView(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size
            , view.isOpaque
            , 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func getHeightAspectRatio(_ size: CGSize, image:  UIImage) -> CGFloat {
        let widthOffset = image.size.width - size.width
        let widthOffsetPercentage = (widthOffset * 100) / image.size.width
        let heightOffset = (widthOffsetPercentage * image.size.height)/100
        let effectiveHeight = image.size.height - heightOffset
        return(effectiveHeight)
    }
    
    static func save(_ image: UIImage, name: String) -> Bool {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false)
            let fileURL = documentDirectory.appendingPathComponent(name)
            if let imageData = image.pngData() {
                try imageData.write(to: fileURL)
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
}

extension UIImage {
    
    func cropped(_ width: Int, height: Int) -> UIImage? {
        let cropRect = CGRect(x: 0, y: 0, width: CGFloat(width) * scale, height: CGFloat(height) * scale)
        guard let croppedCGImage = cgImage?.cropping(to: cropRect) else { return nil }
        return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
    }
    
    func resizedImage(_ newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        /*UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()*/
        
        let width = newSize.width
        let height = newSize.height
        
        let oldWidth = self.size.width
        let oldHeight = self.size.height
        
        let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight
        
        let newHeight = oldHeight * scaleFactor
        let newWidth = oldWidth * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return newImage!
    }
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width * UIScreen.main.scale
        let height = size.height * UIScreen.main.scale
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}
