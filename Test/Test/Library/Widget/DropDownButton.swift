//
//  DropDownButton.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class DropDownButton: UIButton {

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderIBColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    let inset: CGFloat = 5
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //  Default value
        self.borderWidth = 1;
        self.borderIBColor = UIColor.clear
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = self.bounds.width - imageFrame.width - inset
        return imageFrame
    }
    
    override func titleRect(forContentRect contentRect:CGRect) -> CGRect {
        let titleFrame = super.titleRect(forContentRect: contentRect)
//        if (self.currentImage != nil) {
//            titleFrame.origin.x = imageRectforContentRect;: super.imageRectForContentRect(contentRect).minX + inset
//        }
        return titleFrame
    }
    
}
