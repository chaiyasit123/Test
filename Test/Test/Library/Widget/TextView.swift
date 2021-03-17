//
//  TextView.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class TextView: UITextView, UITextViewDelegate {
    
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
    @IBInspectable var localizedText: String {
        get {
            return self.text!
        }
        set {
            self.text = newValue.localized()
        }
    }
    
    
    var isError: Bool = false
    var isPlaceHolderShown: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //  Default value
        self.borderWidth = 1;
        self.borderIBColor = UIColor.clear
    }
    
    override func awakeFromNib() {
        //self.delegate = self
//        self.bounds = CGRectInset(self.frame, 10, 10)
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.lightGrayColor().CGColor
//        self.layer.cornerRadius = 5.0
        
        let appPreference = AppPreference()
        let language = appPreference.getValueString(AppPreference.language)
        var name = ""
        var extranSize = 0
        if language == "th" {
            name = Constant.FONT_TH_NAME
            if (self.font?.fontName.contains("Bold"))! {
                name = Constant.FONT_TH_BOLD_NAME
            }
            extranSize = Constant.FONT_TH_EXTRA_SIZE
        } else {
            name = Constant.FONT_EN_NAME
            if (self.font?.fontName.contains("Bold"))! {
                name = Constant.FONT_EN_BOLD_NAME
            }
        }
        self.font = UIFont(name: name, size: (self.font?.pointSize)! + CGFloat(extranSize))
    }
    
    func setError() {
        isError = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        beginEdit()
    }
    
    func beginEdit() {
        if isError {
            isError = false
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.cornerRadius = 5.0
            //rightViewMode = UITextFieldViewMode.Never
        }
    }
    
}
