//
//  ConfirmDialog.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 7/6/2560 BE.
//  Copyright © 2560 S-Planet. All rights reserved.
//

import UIKit

class ConfirmDialog: UIView {

    typealias AlertDialogCallback = (_ action: Int) -> Void
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var okBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    var dialogView: UIView!
    
    private var callback: AlertDialogCallback?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    private func setupView() {
        dialogView = Bundle.main.loadNibNamed("ConfirmDialog", owner: self, options: nil)?[0] as! UIView
        self.addSubview(dialogView)
        dialogView.frame = self.bounds
        
        dialogView!.layer.shouldRasterize = true
        dialogView!.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        dialogView!.layer.opacity = 0.5
        dialogView!.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    // MARK: - IBAction
    
    @IBAction func onCloseBtnTapped(_ sender: UIButton) {
        self.callback!(0)
        close()
    }
    
    @IBAction func onOKBtnTapped(_ sender: UIButton) {
        self.callback!(1)
        close()
    }
    
    @IBAction func onCancelBtnTapped(_ sender: UIButton) {
        self.callback!(0)
        close()
    }
    
    func show(title: String, message: String, okButtonTitle: String = "btn_ok", cancelButtonTitle: String = "btn_cancel", callback: @escaping AlertDialogCallback) {
        self.titleLabel.text = ""//title
        self.messageLabel.text = message
        self.callback = callback
        self.okBtn.setTitle(okButtonTitle.localized(), for: .normal)
        self.cancelBtn.setTitle(cancelButtonTitle.localized(), for: .normal)
        
        /* */
        UIApplication.shared.windows.first!.addSubview(self)
        UIApplication.shared.windows.first!.endEditing(true)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(DatePickerDialog.deviceOrientationDidChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
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
    
    func show2(title: String, message: NSAttributedString, callback: @escaping AlertDialogCallback) {
        self.titleLabel.text = ""//title
        self.messageLabel.attributedText = message
        self.callback = callback
        
        /* */
        UIApplication.shared.windows.first!.addSubview(self)
        UIApplication.shared.windows.first!.endEditing(true)
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(DatePickerDialog.deviceOrientationDidChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
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
    
    private func close() {
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
                self.dialogView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.layer.opacity = 0
        }) { (finished: Bool) -> Void in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            
            self.removeFromSuperview()
        }
    }
    
}
