//
//  Label.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class Label: UILabel {
    
    @IBInspectable var horizontalPadding: CGFloat = 0
    @IBInspectable var verticalPadding: CGFloat = 0
    @IBInspectable var isCircle: Bool = false
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
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
    @IBInspectable var localizedAttrText: String {
        get {
            return self.text!
        }
        set {
            let appPreference = AppPreference()
            let language = appPreference.getValueString(AppPreference.language)
            var fontName = Constant.FONT_EN_NAME
//            var extraSize = 0
            if language == "th" {
                fontName = Constant.FONT_TH_NAME
//                extraSize = Constant.FONT_TH_EXTRA_SIZE
            }
            let fontSize = Int((self.font?.pointSize)!)
            
            let title = String(format: "%@<style>body{font-family: '%@'; font-size: %dpx; color: %@;}</style>", newValue.localized(), fontName, fontSize, self.textColor.toHexString())
            let titleAttrStr = try! NSAttributedString(
                data: title.data(using: String.Encoding.unicode, allowLossyConversion: true)!
                , options: [ .documentType: NSAttributedString.DocumentType.html]
                , documentAttributes: nil)
            self.attributedText = titleAttrStr
        }
    }
    @IBInspectable var fontName: String {
        get {
            return self.fontName
        }
        set {
            self.font = UIFont(name: newValue, size: self.font.pointSize)
        }
    }
    
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
    
    @IBInspectable var gradientColor1: UIColor!
    @IBInspectable var gradientColor2: UIColor!
    
    var gLayer: CAGradientLayer!
    
    @IBInspectable var isInnerShadow: Bool = false
    @IBInspectable var isVerticalGradient: Bool = false
    @IBInspectable var isHeader: Bool = false
    
    var innerShadow: CALayer!
    
    var insets: UIEdgeInsets!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //  Default value
        self.borderWidth = 1
        self.borderIBColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        let appPreference = AppPreference()
        let language = appPreference.getValueString(AppPreference.language)
        var name = ""
        var extranSize = 0
        if language == "th" {
            name = (isHeader ? Constant.FONT_TH_NAME_HEADER : Constant.FONT_TH_NAME)
            if (self.font?.fontName.contains("Bold"))! {
                name = (isHeader ? Constant.FONT_TH_BOLD_NAME_HEADER : Constant.FONT_TH_BOLD_NAME)
            }
            extranSize = (isHeader ? Constant.FONT_TH_EXTRA_SIZE_HEADER : Constant.FONT_TH_EXTRA_SIZE)
        } else {
            name = (isHeader ? Constant.FONT_EN_NAME_HEADER : Constant.FONT_EN_NAME)
            if (self.font?.fontName.contains("Bold"))! {
                name = (isHeader ? Constant.FONT_EN_BOLD_NAME_HEADER : Constant.FONT_EN_BOLD_NAME)
            }
            extranSize = (isHeader ? Constant.FONT_TH_EXTRA_SIZE_HEADER : Constant.FONT_TH_EXTRA_SIZE)
        }
        self.font = UIFont(name: name, size: (self.font?.pointSize)! + CGFloat(extranSize))
        
        if cornerRadius > 0.0 {
            self.layer.masksToBounds = true
            self.clipsToBounds = true
        }
        
        if isCircle {
            let width = self.frame.width
            self.layer.cornerRadius = width / 2
            self.layer.masksToBounds = true
            self.clipsToBounds = true
        }
        
        
        if gradientColor1 != nil && gradientColor2 != nil {
            gLayer = CAGradientLayer()
            
            gLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
            gLayer.locations = [0.0, 1.0]
            
            if isVerticalGradient {
                gLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            } else {
                gLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            }
            
            self.layer.insertSublayer(gLayer, at: 0)
            self.clipsToBounds = true
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isInnerShadow {
            addInnerShadow()
        }
        
        //  Update gradient
        if gradientColor1 != nil && gradientColor2 != nil {
            gLayer.frame = self.bounds
        }
    }
    
    override func drawText(in rect: CGRect) {
        if insets == nil {
            super.drawText(in: rect)
        } else {
            super.drawText(in: rect.inset(by: insets))
        }
    }
    
    override var intrinsicContentSize: CGSize {
        insets = UIEdgeInsets(top: verticalPadding
            , left: horizontalPadding
            , bottom: verticalPadding
            , right: horizontalPadding)
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.height += insets.top + insets.bottom
        intrinsicContentSize.width += insets.left + insets.right
        return intrinsicContentSize
    }
    
    private func addInnerShadow() {
        if innerShadow == nil {
            innerShadow = CALayer()
            innerShadow.frame = bounds
            
            // Shadow path (1pt ring around bounds)
            let radius = self.frame.size.height / 2
            let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -1, dy:-1), cornerRadius:radius)
            let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:radius).reversing()
            
            path.append(cutout)
            innerShadow.shadowPath = path.cgPath
            innerShadow.masksToBounds = true
            // Shadow properties
            innerShadow.shadowColor = UIColor.black.cgColor
            innerShadow.shadowOffset = CGSize(width: 0, height: 3)
            innerShadow.shadowOpacity = 0.5
            innerShadow.shadowRadius = (isCircle ? self.frame.size.height / 2 : cornerRadius)
            innerShadow.cornerRadius = (isCircle ? self.frame.size.height / 2 : cornerRadius)
            layer.addSublayer(innerShadow)
        }
    }
    
    /*override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }*/
    
    /*override func intrinsicContentSize() -> CGSize {
        insets = UIEdgeInsets(top: verticalPadding
            , left: horizontalPadding
            , bottom: verticalPadding
            , right: horizontalPadding)
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.height += insets.top + insets.bottom
        intrinsicContentSize.width += insets.left + insets.right
        return intrinsicContentSize
    }*/
    
}

extension UILabel {
    
    func setText(_ text: String, withColorPart colorTextPart: String, color: UIColor) {
        attributedText = nil
        let result =  NSMutableAttributedString(string: text)
        result.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSString(string: text.lowercased()).range(of: colorTextPart.lowercased()))
        attributedText = result
    }
    
    func setTextlineStyleSingle(_ text: String, withColorPart colorTextPart: String, color: UIColor) {
        attributedText = nil
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.underlineColor: color,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let result =  NSMutableAttributedString(string: text)
        result.addAttributes(linkAttributes, range: NSString(string: text.lowercased()).range(of: colorTextPart.lowercased()))
        result.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: 0x6F7179), range: NSString(string: text.lowercased()).range(of: "readmore".localized().lowercased()))
        attributedText = result
    }
    
}
