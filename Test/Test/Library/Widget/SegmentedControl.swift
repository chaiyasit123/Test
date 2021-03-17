//
//  SegmentedControl.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class SegmentedControl: UISegmentedControl {
    
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
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var textColor: UIColor {
        get {
            return self.textColor
        }
        set {
            self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: newValue], for: .selected)
        }
    }
    
    @IBInspectable var localizedText: String = ""
    
    @IBInspectable var isBorderRemoved: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //  Default value
        self.borderWidth = 1
        self.borderIBColor = UIColor.clear
        
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        if isBorderRemoved {
            removeBorders()
        }
        
        var textArr = localizedText.components(separatedBy: ",")
        for i in 0..<textArr.count {
            self.setTitle(textArr[i].localized(), forSegmentAt: i)
        }
    }
    
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
    
}
