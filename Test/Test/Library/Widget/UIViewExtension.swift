//
//  UIViewExtension.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn() {
        if self.isHidden {
            self.alpha = 0.0
            self.isHidden = false
            UIView.animate(withDuration: 0.3
                , delay: 0.0
                , options: UIView.AnimationOptions.curveEaseIn
                , animations: {
                    self.alpha = 1.0
                }, completion: nil)
        }
    }
    
    func fadeIn(_ alpha: CGFloat) {
        if self.isHidden {
            self.alpha = 0.0
            self.isHidden = false
            UIView.animate(withDuration: 0.3
                , delay: 0.0
                , options: UIView.AnimationOptions.curveEaseIn
                , animations: {
                    self.alpha = alpha
                }, completion: nil)
        }
    }
    
    func fadeOut() {
        if !self.isHidden {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.3
                , delay: 0.0
                , options: UIView.AnimationOptions.curveEaseOut
                , animations: {
                    self.alpha = 0.0
                }, completion: { finished in
                    self.isHidden = true
            })
        }
    }
    
    func fadeOut(_ alpha: CGFloat) {
        if !self.isHidden {
            self.alpha = alpha
            UIView.animate(withDuration: 0.3
                , delay: 0.0
                , options: UIView.AnimationOptions.curveEaseOut
                , animations: {
                    self.alpha = 0.0
                }, completion: { finished in
                    self.isHidden = true
            })
        }
    }
    
    func ring() {
        self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: 1.0
            , delay: 0.0
            , usingSpringWithDamping: 0.5
            , initialSpringVelocity: 0.5
            , options: UIView.AnimationOptions.curveEaseIn
            , animations: { () -> Void in
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
    }
    
    func slideUp(startOffset: CGFloat, endOffset: CGFloat, hideWhenFinished: Bool = true, delay: Double = 0.0) {
//        self.alpha = 1.0
        if hideWhenFinished {
            self.isHidden = false
        }
        self.transform = CGAffineTransform(translationX: 0, y: startOffset)
        UIView.animate(withDuration: 0.3
            , delay: delay
            , options: UIView.AnimationOptions.curveEaseOut
            , animations: {
                //                self.alpha = 1.0
                self.transform = CGAffineTransform(translationX: 0, y: endOffset)
        }, completion: { finished in
            if hideWhenFinished {
                self.isHidden = true
            }
        })
    }
    
    func slideDown(startOffset: CGFloat, endOffset: CGFloat, hideWhenFinished: Bool = true, delay: Double = 0.0) {
//        self.alpha = 0.0
        self.transform = CGAffineTransform(translationX: 0, y: startOffset)
        if !hideWhenFinished {
            self.isHidden = false
        }
        UIView.animate(withDuration: 0.3
            , delay: delay
            , options: UIView.AnimationOptions.curveEaseOut
            , animations: {
//                self.alpha = 0.0
                self.transform = CGAffineTransform(translationX: 0, y: endOffset)
        }, completion: { finished in
        })
    }
    
    func addToCart(_ imageUrl: String, sender: UIView, container: UIView) {
        //  Show add to cart animation
        let frame = sender.superview?.convert(sender.frame, to: container)
        var point = (frame?.origin)!
        point.x += (sender.frame.size.width / 2)
        point.y += (sender.frame.size.height / 2)
        self.frame.origin = point
        self.isHidden = false
        self.alpha = 1.0
        
        //  Animate
        let x = container.frame.width - self.frame.width - 20
        let y = container.frame.height - self.frame.height - 20
        UIView.animate(withDuration: 1.2
            , delay: 0
            , options: UIView.AnimationOptions.curveEaseOut
            , animations: {
                var origin = self.frame.origin
                origin.x = x
                origin.y = y
                self.frame.origin = origin
        }, completion: { finished in
            self.fadeOut()
        })
    }
    
}
