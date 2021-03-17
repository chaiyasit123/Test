//
//  Screenshot.swift
//  M Help Me
//
//  Created by Nattapon Phothima on 19/7/2562 BE.
//  Copyright © 2562 S-planet. All rights reserved.
//

import Foundation
import UIKit

open class Screenshot: NSObject {
    
    private var tableView: UITableView!
    private var view: UIView!
    private var image: UIImage!
    private var fileUrl: String!
    private var subtractHeight: CGFloat = 0.0
    
    public init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    public init(view: UIView) {
        self.view = view
    }
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public func setSubtractHeight(height: CGFloat) {
        self.subtractHeight = height
    }
    
    public func setImageFromTableView() {
        //  Create the UIImage
        UIGraphicsBeginImageContextWithOptions(CGSize(width: tableView.contentSize.width, height: (tableView.contentSize.height - subtractHeight)), false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        let previousFrame = tableView.frame
        
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.contentSize.width, height: tableView.contentSize.height);
        
        tableView.layer.render(in: context!)
        
        tableView.frame = previousFrame
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        self.image = image!
    }
    
    public func getImageFromTableView() -> UIImage {
        return image
    }
    
    public func setImageFromView() {
        //  Create the UIImage
        UIGraphicsBeginImageContextWithOptions(CGSize(width: view.bounds.width, height: view.bounds.height), false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        let previousFrame = view.frame
        
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.bounds.width, height: view.bounds.height);
        
        view.layer.render(in: context!)
        
        view.frame = previousFrame
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        self.image = image!
    }
    
    public func getImageFromView() -> UIImage {
        return image
    }
    
    public func saveImageToAlbum() {
        //  Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    public func setFileUrl() {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory
            , in: .userDomainMask)[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let fileName = dateFormatter.string(from: Date()) + ".png"
        let fileUrl = documentsUrl.appendingPathComponent(fileName)
        let imageData = image.pngData()
        do {
            try imageData!.write(to: fileUrl)
        } catch {
            
        }
        
        self.fileUrl = fileUrl.absoluteString
    }
    
    public func getFileUrl() -> String {
        return fileUrl
    }
    
}
