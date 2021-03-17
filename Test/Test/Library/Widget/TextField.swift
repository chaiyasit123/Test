//
//  TextField.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    @IBOutlet var validateLabel: UILabel!
    
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
    @IBInspectable var horizontalPadding: CGFloat = 0
    @IBInspectable var verticalPadding: CGFloat = 0
    @IBInspectable var isCardView: Bool = false
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
            return self.placeholder!
        }
        set {
            self.placeholder = newValue.localized()
        }
    }
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    var maxLengths = [UITextField: Int]()
    @IBInspectable var maxLength: Int {
        get {
            guard let l = maxLengths[self] else {
               return 150
            }
            return l
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
        
    @objc func fix(textField: UITextField) {
        textField.text = String(textField.text!.prefix(maxLength))
    }
    //    @IBInspectable var fontName: String {
    //        get {
    //            return self.fontName
    //        }
    //        set {
    //            self.font = UIFont(name: newValue, size: (self.font?.pointSize)!)
    //        }
    //    }
    
    open var errorMessage: String? {
        didSet {
            updateControl()
        }
    }
    
    open var hasErrorMessage: Bool {
        return errorMessage != nil && errorMessage != ""
    }
    
    var insets: UIEdgeInsets!
    var error: String!
    var defaultText: String!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        if isCardView {
            addCardShadow()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //  Default value
        self.borderWidth = 1
        self.borderIBColor = UIColor.clear
        
        self.autocorrectionType = .no
        
        insets = UIEdgeInsets(top: verticalPadding
            , left: horizontalPadding
            , bottom: verticalPadding
            , right: horizontalPadding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        insets = UIEdgeInsets(top: verticalPadding
            , left: horizontalPadding
            , bottom: verticalPadding
            , right: horizontalPadding)
    }
    
    override func awakeFromNib() {
        insets = UIEdgeInsets(top: verticalPadding
            , left: horizontalPadding
            , bottom: verticalPadding
            , right: horizontalPadding)
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
        
        /*let imageView = UIImageView()
         let image = UIImage(named: "AlertIcon")
         imageView.image = image
         imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
         rightView = imageView
         rightViewMode = UITextFieldViewMode.Never*/
        /*let tapGestureRecognizer = UITapGestureRecognizer(target:self
         , action:Selector("errorIconTapped:"))
         imageView.userInteractionEnabled = true
         imageView.addGestureRecognizer(tapGestureRecognizer)*/
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return insets == nil ? bounds : bounds.inset(by: insets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return insets == nil ? bounds : bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return insets == nil ? bounds : bounds.inset(by: insets)
    }
    
    fileprivate func updateControl() {
        if validateLabel != nil {
            validateLabel.text = hasErrorMessage ? errorMessage : ""
        }
    }
    
    private func addCardShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
    }
    
}
