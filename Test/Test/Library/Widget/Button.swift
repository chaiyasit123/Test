//
//  Button.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class Button: UIButton {
    
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
    @IBInspectable var localizedText: String {
        get {
            return self.currentTitle!
        }
        set {
            self.setTitle(newValue.localized(), for: .normal)
        }
    }
    
    @IBInspectable var isUnderline: Bool {
        get {
            return true
        }
        set {
            guard let text = self.titleLabel?.text else { return }
            
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
//    @IBInspectable var fontName: String {
//        get {
//            return self.fontName
//        }
//        set {
//            self.titleLabel?.font = UIFont(name: newValue, size: (self.titleLabel?.font.pointSize)!)
//        }
//    }
        
    var lineView: UIView!
    
    @IBInspectable var hasLine: Bool = false {
        didSet {
            createLineView()
            updateLineView()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable dynamic open var lineHeight: CGFloat = 3.0 {
        didSet {
            updateLineView()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var isAlignVerticalCenter: Bool = false
    @IBInspectable var verticalSpacing: CGFloat = 4.0
    
    var section = 0
    
    @IBInspectable var gradientColor1: UIColor!
    @IBInspectable var gradientColor2: UIColor!
    
    @IBInspectable var isVerticalGradient: Bool = false
    @IBInspectable var isHorizontalGradient: Bool = false
    @IBInspectable var isBorderGradient: Bool = false
    @IBInspectable var isHeader: Bool = false
    @IBInspectable var isCardView: Bool = false

    var gLayer: CAGradientLayer!
    var shapeLayer: CAShapeLayer!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //  Default value
        self.borderWidth = 1
        self.borderIBColor = UIColor.clear
        
        createLineView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLineView()
    }
    
    fileprivate func createLineView() {
        if lineView == nil && hasLine {
            let lineView = UIView()
            lineView.isUserInteractionEnabled = false
            lineView.backgroundColor = UIColor(hex: 0x000000, alpha: 0.3)
            self.lineView = lineView
//            configureDefaultLineHeight()
        }
        
        if lineView != nil {
            lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            addSubview(lineView)
        }
    }
    
//    fileprivate func configureDefaultLineHeight() {
//        let onePixel: CGFloat = 1.0 / UIScreen.main.scale
//        lineHeight = 2.0 * onePixel
//    }
    
    fileprivate func updateLineView() {
        if let lineView = lineView {
            lineView.frame = lineViewRectForBounds(bounds)
        }
    }
    
    open func lineViewRectForBounds(_ bounds: CGRect) -> CGRect {
        let height = lineHeight
        return CGRect(x: 0, y: bounds.size.height - height, width: bounds.size.width, height: height)
    }
    
    override func awakeFromNib() {
        let appPreference = AppPreference()
        let language = appPreference.getValueString(AppPreference.language)
        var name = ""
        var extraSize = 0
        if language == "th" {
            name = (isHeader ? Constant.FONT_TH_NAME_HEADER : Constant.FONT_TH_NAME)
            if (self.titleLabel?.font.fontName.contains("Bold"))! {
                name = (isHeader ? Constant.FONT_TH_BOLD_NAME_HEADER : Constant.FONT_TH_BOLD_NAME)
            }
            extraSize = (isHeader ? Constant.FONT_TH_EXTRA_SIZE_HEADER : Constant.FONT_TH_EXTRA_SIZE)
        } else {
            name = (isHeader ? Constant.FONT_EN_NAME_HEADER : Constant.FONT_EN_NAME)
            if (self.titleLabel?.font.fontName.contains("Bold"))! {
                name = (isHeader ? Constant.FONT_EN_BOLD_NAME_HEADER : Constant.FONT_EN_BOLD_NAME)
            }
            extraSize = (isHeader ? Constant.FONT_TH_EXTRA_SIZE_HEADER : Constant.FONT_TH_EXTRA_SIZE)
        }
        
        
        self.titleLabel?.font = UIFont(name: name, size: (self.titleLabel?.font.pointSize)! + CGFloat(extraSize))
        
        if isCircle {
            let width = self.frame.width
            self.layer.cornerRadius = width / 2
            self.layer.masksToBounds = true
        }
        
        if gradientColor1 != nil && gradientColor2 != nil {
            gLayer = CAGradientLayer()
            
            gLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
            gLayer.locations = [0.0, 1.0]
            
            //gLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            //gLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
            if isVerticalGradient {
                gLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            } else {
                gLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            }
            
            if isHorizontalGradient {
                gLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                gLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            } else {
                gLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            }
            
            if isBorderGradient {
                shapeLayer = CAShapeLayer()
                shapeLayer.lineWidth = layer.borderWidth
                shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
                shapeLayer.strokeColor = UIColor.black.cgColor
                shapeLayer.fillColor = UIColor.clear.cgColor
                gLayer.mask = shapeLayer
            }
            self.layer.insertSublayer(gLayer, at: 0)
        }
        
        self.clipsToBounds = true
        
        if isAlignVerticalCenter {
            alignVertical()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //  Update gradient
        if gradientColor1 != nil && gradientColor2 != nil {
            gLayer.frame = self.bounds
            if shapeLayer != nil {
                shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
            }
        }
        
        if isCardView {
            addCardShadow()
        }
    }
    
    func alignVertical() {
        let spacing = verticalSpacing
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
    
    private func addCardShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
    }
}
