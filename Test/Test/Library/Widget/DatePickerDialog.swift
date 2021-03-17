import Foundation
import UIKit
import QuartzCore

class DatePickerDialog: UIView {
    
    typealias DatePickerCallback = (_ date: NSDate) -> Void
    
    /* Consts */
    private let kDatePickerDialogDefaultButtonHeight:       CGFloat = 45
    private let kDatePickerDialogDefaultButtonSpacerHeight: CGFloat = 1
    private let kDatePickerDialogCornerRadius:              CGFloat = 10
    private let kDatePickerDialogDoneButtonTag:             Int     = 1
    
    /* Views */
    private var dialogView:   UIView!
    private var titleLabel:   UILabel!
    private var datePicker:   UIDatePicker!
    private var cancelButton: UIButton!
    private var doneButton:   UIButton!
    
    /* Vars */
    private var defaultDate:    NSDate?
    private var datePickerMode: UIDatePicker.Mode?
    private var callback:       DatePickerCallback?
    
    private var hideCancel: Bool = false
    
    /* Overrides */
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        setupView()
    }
    
    init(hideCancel: Bool) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.hideCancel = hideCancel
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.dialogView = createContainerView()
    
        self.dialogView!.layer.shouldRasterize = true
        self.dialogView!.layer.rasterizationScale = UIScreen.main.scale
    
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    
        self.dialogView!.layer.opacity = 0.5
        self.dialogView!.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
    
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
        self.addSubview(self.dialogView!)
    }
    
    /* Handle device orientation changes */
    @objc func deviceOrientationDidChange(notification: NSNotification) {
        //close() // For now just close it
    }
    
    /* Create the dialog view, and animate opening the dialog */
    func show(title: String, doneButtonTitle: String = "Done", cancelButtonTitle: String = "Cancel", defaultDate: NSDate = NSDate(), datePickerMode: UIDatePicker.Mode = .dateAndTime, callback: @escaping DatePickerCallback) {
        self.titleLabel.text = title
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        if !hideCancel {
            self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
        self.datePickerMode = datePickerMode
        self.callback = callback
        self.defaultDate = defaultDate
        self.datePicker.datePickerMode = self.datePickerMode ?? .date
        
//        currentDate
//        let appPreference = AppPreference()
//        let language = appPreference.getValueString(AppPreference.language)
        let date = (self.defaultDate ?? NSDate()) as Date
//        if language == "th" {
//            let calendar = Calendar(identifier: .gregorian)
//            date = calendar.date(byAdding: .year, value: 543, to: date)!
//        }
        
        self.datePicker.date = date
        
        /* */
        UIApplication.shared.windows.first!.addSubview(self)
        UIApplication.shared.windows.first!.endEditing(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DatePickerDialog.deviceOrientationDidChange(notification:)), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        /* Anim */
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
                self.dialogView!.layer.opacity = 1
                self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
            },
            completion: nil
        )
    }
    
    func show(title: String, doneButtonTitle: String = "Done", cancelButtonTitle: String = "Cancel", defaultDate: NSDate = NSDate(), maxDate: NSDate, datePickerMode: UIDatePicker.Mode = .dateAndTime, callback: @escaping DatePickerCallback) {
        self.titleLabel.text = title
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        if !hideCancel {
            self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
        self.datePickerMode = datePickerMode
        self.callback = callback
        self.defaultDate = defaultDate
        self.datePicker.datePickerMode = self.datePickerMode ?? .date
        //self.datePicker.maximumDate = maxDate as Date
        
        //        currentDate
        //        let appPreference = AppPreference()
        //        let language = appPreference.getValueString(AppPreference.language)
        let date = (self.defaultDate ?? NSDate()) as Date
        //        if language == "th" {
        //            let calendar = Calendar(identifier: .gregorian)
        //            date = calendar.date(byAdding: .year, value: 543, to: date)!
        //        }
        
        self.datePicker.date = date
        
        /* */
        UIApplication.shared.windows.first!.addSubview(self)
        UIApplication.shared.windows.first!.endEditing(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DatePickerDialog.deviceOrientationDidChange(notification:)), name: UIDevice.orientationDidChangeNotification, object: nil)

        /* Anim */
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
                self.dialogView!.layer.opacity = 1
                self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
        },
            completion: nil
        )
    }
    
    /* Dialog close animation then cleaning and removing the view from the parent */
    private func close() {
        NotificationCenter.default.removeObserver(self)
        
        let currentTransform = self.dialogView.layer.transform
        
        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + Double.pi * 270 / 180), 0, 0, 0)
        
        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.opacity = 0
            }) { (finished: Bool) -> Void in
                for v in self.subviews {
                    v.removeFromSuperview()
                }
                
                self.removeFromSuperview()
        }
    }
    
    /* Creates the container view here: create the dialog, then add the custom content and buttons */
    private func createContainerView() -> UIView {
        let screenSize = countScreenSize()
        let dialogSize = CGSize(
            width: 300,
            height: 230
                + kDatePickerDialogDefaultButtonHeight
                + kDatePickerDialogDefaultButtonSpacerHeight)
        
        // For the black background
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        // This is the dialog's container; we attach the custom content and the buttons to this one
        let dialogContainer = UIView(frame: CGRect(x: (screenSize.width - dialogSize.width) / 2, y: (screenSize.height - dialogSize.height) / 2, width: dialogSize.width, height: dialogSize.height))
        
        // First, we style the dialog to match the iOS8 UIAlertView >>>
//        let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer)
//        gradient.frame = dialogContainer.bounds
//        gradient.colors = [UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).CGColor,
//            UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).CGColor,
//            UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).CGColor]
        
        let cornerRadius = kDatePickerDialogCornerRadius
//        gradient.cornerRadius = cornerRadius
        //dialogContainer.layer.insertSublayer(gradient, atIndex: 0)
        dialogContainer.backgroundColor = UIColor.white
        
        dialogContainer.layer.cornerRadius = cornerRadius
        dialogContainer.layer.masksToBounds = true
//        dialogContainer.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).CGColor
//        dialogContainer.layer.borderWidth = 1
        dialogContainer.layer.shadowRadius = cornerRadius + 5
        dialogContainer.layer.shadowOpacity = 0.1
        dialogContainer.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
        dialogContainer.layer.shadowColor = UIColor.black.cgColor
        dialogContainer.layer.shadowPath = UIBezierPath(roundedRect: dialogContainer.bounds, cornerRadius: dialogContainer.layer.cornerRadius).cgPath
        
        // There is a line above the button
        let lineView = UIView(frame: CGRect(x: 0, y: dialogContainer.bounds.size.height - kDatePickerDialogDefaultButtonHeight - kDatePickerDialogDefaultButtonSpacerHeight, width: dialogContainer.bounds.size.width, height: kDatePickerDialogDefaultButtonSpacerHeight))
        lineView.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        dialogContainer.addSubview(lineView)
        // ˆˆˆ
        
        //Title
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: dialogContainer.bounds.size.width, height: 40))
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.backgroundColor = UIColor(hex: Constant.COLOR_TITLE_TEXT)
        dialogContainer.addSubview(self.titleLabel)
        
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: 0, height: 0))
        self.datePicker.autoresizingMask = UIView.AutoresizingMask.flexibleRightMargin
        self.datePicker.frame.size.width = 300
        
        //  Set locale
        let appPreference = AppPreference()
        let language = appPreference.getValueString(AppPreference.language)
        self.datePicker.calendar = Calendar(identifier: (language == "en" ? .gregorian : .buddhist))
        self.datePicker.locale = Locale(identifier: language)
        dialogContainer.addSubview(self.datePicker)
        
        // Add the buttons
        addButtonsToView(container: dialogContainer)
        
        return dialogContainer
    }
    
    /* Add buttons to container */
    private func addButtonsToView(container: UIView) {
        let buttonWidth = container.bounds.size.width / 2
        
        if !hideCancel {
            self.cancelButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
            self.cancelButton.frame = CGRect(
                x: 0,
                y: container.bounds.size.height - kDatePickerDialogDefaultButtonHeight,
                width: buttonWidth,
                height: kDatePickerDialogDefaultButtonHeight
            )
            //        self.cancelButton.setTitleColor(UIColor(red: 0, green: 0.5, blue: 1, alpha: 1), forState: UIControlState.Normal)
            self.cancelButton.setTitleColor(UIColor.black, for: .normal)
            self.cancelButton.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5), for: UIControl.State.highlighted)
            self.cancelButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 15)
            self.cancelButton.backgroundColor = UIColor(hex: Constant.COLOR_POPUP)
    //        self.cancelButton.layer.cornerRadius = kDatePickerDialogCornerRadius
            self.cancelButton.addTarget(self, action: #selector(DatePickerDialog.buttonTapped(sender:)), for: UIControl.Event.touchUpInside)
            container.addSubview(self.cancelButton)
        }
        
        self.doneButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        
        self.doneButton.frame = CGRect(
            x: (hideCancel ? 0 : buttonWidth),
            y: container.bounds.size.height - kDatePickerDialogDefaultButtonHeight,
            width: (hideCancel ? 2 * buttonWidth : buttonWidth),
            height: kDatePickerDialogDefaultButtonHeight
        )
        self.doneButton.tag = kDatePickerDialogDoneButtonTag
//        self.doneButton.setTitleColor(UIColor(red: 0, green: 0.5, blue: 1, alpha: 1), forState: UIControlState.Normal)
        self.doneButton.setTitleColor(UIColor.white, for: .normal)
        self.doneButton.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5), for: UIControl.State.highlighted)
        self.doneButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 15)
        self.doneButton.backgroundColor = UIColor(hex: Constant.COLOR_PRIMARY)
//        self.doneButton.layer.cornerRadius = kDatePickerDialogCornerRadius
        self.doneButton.addTarget(self, action: #selector(DatePickerDialog.buttonTapped(sender:)), for: UIControl.Event.touchUpInside)
        container.addSubview(self.doneButton)
    }
    
    @objc func buttonTapped(sender: UIButton!) {
        if sender.tag == kDatePickerDialogDoneButtonTag {
            self.callback?(self.datePicker.date as NSDate)
        }
        
        close()
    }
    
    /* Helper function: count and return the screen's size */
    func countScreenSize() -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
}
