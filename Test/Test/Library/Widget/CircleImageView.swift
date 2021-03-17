//
//  CircleImageView.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //  Default value
        self.borderWidth = 1;
        self.borderIBColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width = frame.width
        //        var height = self.frame.height
        self.layer.cornerRadius = width / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        let width = self.frame.width
//        var height = self.frame.height
        self.layer.cornerRadius = width / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
}
