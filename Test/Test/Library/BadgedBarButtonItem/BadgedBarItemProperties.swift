//
//  BadgeProperties.swift
//  BadgedBarButtonItem
//
//  Created by Eric Miller on 3/31/17.
//  Copyright © 2017 Tiny Zepplin. All rights reserved.
//

import UIKit

open class BadgeProperties {
    
    /**
     The initial frame of the badge.
     Defaults to CGRect.zero
     */
    open var originalFrame: CGRect
    
    /**
     The minimum width the badge can be.
     Defaults to 8.0
     */
    open var minimumWidth: CGFloat
    
    /**
     The additional horizontal padding of the badge
     Defaults to 4.0
    */
    open var horizontalPadding: CGFloat
    
    /**
     The additional vertical padding of the badge.
     Defaults to 0.0
     */
    open var verticalPadding: CGFloat
    
    open var font: UIFont
    open var textColor: UIColor
    open var backgroundColor: UIColor
    
    /**
     A quick way to instantiate badge properties with their default values.
    */
    public static let `default` = BadgeProperties()
    
    public init(
        originalFrame: CGRect = CGRect.zero,
        minimumWidth: CGFloat = 8.0,
        horizontalPadding: CGFloat = 4.0,
        verticalPadding: CGFloat = 0.0,
        font: UIFont = UIFont.systemFont(ofSize: 12.0),
        textColor: UIColor = UIColor.white,
        backgroundColor: UIColor = UIColor.red
        ) {
        self.originalFrame = originalFrame
        self.minimumWidth = minimumWidth
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}
