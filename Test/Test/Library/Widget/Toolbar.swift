//
//  Toolbar.swift
//  LuckyDraw
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

class Toolbar {
    
    static func sync(_ controller: UIViewController, title: String, isLocalized: Bool = true) {
        //  Navigation title
        controller.title = isLocalized ? title.localized() : title
        
        //  Custom back icon
        var image = UIImage(named: "BackIcon")
        image = image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0))
        controller.navigationController?.navigationBar.backIndicatorImage = image
        controller.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        
//        controller.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: ""
//            , style: .plain
//            , target: nil
//            , action: nil)
//        
//        //  Another back button in navigation controller
//        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: ""
//            , style: .plain
//            , target: nil
//            , action: nil)
        
        //  Add notification to all controller
        /*let image2 = UIImage(named: "AlertWhiteIcon")
        let buttonFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: image2!.size.width, height: image2!.size.height)
        
        //  Get notification count
        let appPreference = AppPreference()
        let notificationCount = appPreference.getValueInt(AppPreference.notificationCount)
        
        let notifcationItem = BadgedBarButtonItem(
            startingBadgeValue: 0,
            frame: buttonFrame,
            image: image2
        )
        notifcationItem.badgeValue = notificationCount
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        notifcationItem.addTarget(appDelegate, action: #selector(appDelegate.onNotificationBtnTapped(_:)))
        controller.navigationItem.rightBarButtonItem = notifcationItem*/
    }
    
    static func sync(_ controller: UIViewController, title: String, isLocalized: Bool = true, onlyBackButton: Bool = false) {
        //  Navigation title
        controller.title = isLocalized ? title.localized() : title
        
        //  Custom back icon
        if onlyBackButton {
            var image = UIImage(named: "BackBlackIcon")
            image = image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0))
            controller.navigationController?.navigationBar.backIndicatorImage = image
            controller.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        } else {
            controller.navigationItem.setHidesBackButton(true, animated: true)
            
            //  Add notification to all controller
            let image2 = UIImage(named: "AlertWhiteIcon")
            let buttonFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: image2!.size.width, height: image2!.size.height)
            
            //  Get notification count
            let appPreference = AppPreference()
            
            let notifcationItem = BadgedBarButtonItem(
                startingBadgeValue: 0,
                frame: buttonFrame,
                image: image2
            )
            _ = UIApplication.shared.delegate as! AppDelegate
//            notifcationItem.addTarget(appDelegate, action: #selector(appDelegate.onNotificationBtnTapped(_:)))
            
            //        let notifcationItem = UIBarButtonItem(image: UIImage(named: "NotificationFullIcon")
            //            , style: .plain
            //            , target: appDelegate
            //            , action: #selector(appDelegate.onNotificationBtnTapped))
            controller.navigationItem.rightBarButtonItem = notifcationItem
        }
        
        //  First back button
        controller.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: ""
            , style: .plain
            , target: nil
            , action: nil)
        
        //  Another back button in navigation controller
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: ""
            , style: .plain
            , target: nil
            , action: nil)
    }
    
    static func sync(_ controller: UIViewController, title: String, isLocalized: Bool = true, isCustomNavigationBar: Bool) {
        //  Navigation title
        controller.title = isLocalized ? title.localized() : title
        
        if isCustomNavigationBar {
            var image = UIImage(named: "")
            image = image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0))
            controller.navigationController?.navigationBar.backIndicatorImage = image
            controller.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
            
//            //  First back button
//            controller.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: ""
//                , style: .plain
//                , target: nil
//                , action: nil)
//            
//            //  Another back button in navigation controller
//            controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: ""
//                , style: .plain
//                , target: nil
//                , action: nil)
            
            controller.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
    
    static func sync(_ controller: UIViewController, title: String, isLocalized: Bool = true, isShoppingBar: Bool) {
        //  Navigation title
        controller.title = isLocalized ? title.localized() : title
        
        //  Custom back icon
        var image = UIImage(named: "BackIcon")
        image = image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0))
        controller.navigationController?.navigationBar.backIndicatorImage = image
        controller.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        
        controller.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: ""
            , style: .plain
            , target: nil
            , action: nil)
        
        //  Another back button in navigation controller
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: ""
            , style: .plain
            , target: nil
            , action: nil)
        
        //  Add notification to all controller
        let image2 = UIImage(named: "settingIcon")
        let buttonFrame: CGRect = CGRect(x: 0.0, y: 0.0, width: image2!.size.width, height: image2!.size.height)
        
        //  Get notification count
        let dummyBtn = UIBarButtonItem(title: ""
            , style: .plain
            , target: nil
            , action: nil)
        let appPreference = AppPreference()
        
        let notifcationItem = BadgedBarButtonItem(
            startingBadgeValue: 0,
            frame: buttonFrame,
            image: image2
        )
        notifcationItem.isShoppingButtonItem = true
        _ = UIApplication.shared.delegate as! AppDelegate
//        notifcationItem.addTarget(appDelegate, action: #selector(appDelegate.onCartBtnTapped(_:)))
        controller.navigationItem.rightBarButtonItems = [notifcationItem, dummyBtn]
    }
    
}
