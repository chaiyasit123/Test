//
//  ImageView.swift
//  MSinging
//
//  Created by Tanawat Suriyachai on 1/17/2561 BE.
//  Copyright © 2561 Tanawat Suriyachai. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
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
    
    @IBInspectable var isCircle: Bool = false
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
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
    }
    
    override func awakeFromNib() {
        if cornerRadius > 0.0 {
            self.layer.masksToBounds = true
            self.clipsToBounds = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isCircle {
            let width = self.frame.width
            self.layer.cornerRadius = width / 2
            self.layer.masksToBounds = true
            self.clipsToBounds = true
        }
    }
    
}
