//
//  Constant.swift
//  MasterTemplate
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static let DEFAULT_LANGUAGE = "th"
    
    static let MIN_DEVICE_HEIGHT = CGFloat(568)
    static let IPHONE_5_HEIGHT = CGFloat(1136)
    static let IPHONE_6_HEIGHT = CGFloat(1334)
    static let IPHONE_8_HEIGHT = CGFloat(2208)
    static let IPHONE_X_HEIGHT = CGFloat(2436)
    
    static let iPhone4 = 480
    static let iPhone5 = 568
    static let iPhone6 = 667
    static let iPhone6plus = 736
    static let iPhoneXR = 1792
    static let iPad = 1024
    
    static let BRAND = "iOS"
    
    static let API_KEY = "38e610f8a15dfb13adb5d0929a7a3108"
    static let API_KEY_Node = "SCREENCLEANINGKIT2019"
    
    //  Location

    static let LOCATION_MAX_RADIUS = 5.0
    static let LOCATION_DEFAULT_LAT = 13.7758427
    static let LOCATION_DEFAULT_LNG = 100.5737384
    static let MAP_ZOOM: Float = 15
    
    //  Font
    
    static var FONT_EN_NAME = "CSPraKasFD"
    static var FONT_EN_BOLD_NAME = "CSPraKasFD-Bold"
    static var FONT_TH_NAME = "CSPraKasFD"
    static var FONT_TH_BOLD_NAME = "CSPraKasFD-Bold"
    static var FONT_TH_EXTRA_SIZE = -2
    static var FONT_BUTTON = "CSPraKas"
    static var FONT_BUTTON_BOLD = "CSPraKasBold"
    static var FONT_TH_NAME_HEADER = "Prompt-Light"
    static var FONT_TH_BOLD_NAME_HEADER = "Prompt-Medium"
    static var FONT_EN_NAME_HEADER = "Prompt-Light"
    static var FONT_EN_BOLD_NAME_HEADER = "Prompt-Medium"
    static var FONT_TH_NAME_ITALIC = "Prompt-Italic"
    static var FONT_TH_NAME_DIGITAL = "Digital-7"
    static var FONT_TH_NAME_SLOGAN = "NotoSansThai-Regular"
    static var FONT_TH_EXTRA_SIZE_HEADER = -2
    
    //  Delay
    
    static let BANNER_SLIDE_DELAY = 5.0
    
    //  Location
    static var LAT = 0.00
    static var LNG = 0.00
    
    //  Color

    static let COLOR_PRIMARY = 0xF80759
    static let COLOR_PRIMARY2 = 0x711E84
    static let COLOR_ACCENT = 0xF80759
    static let COLOR_ACCENT2 = 0x711E84
    
    static let COLOR_POPUP = 0xAAAAAA
    static let COLOR_ACCENT_SUB = 0xf0a4b8
    static let COLOR_TITLE_TEXT = 0x54585a
    static let COLOR_TAB_TITLE = 0xb6b6b6
    static let COLOR_TAB_TITLE_ACTIVE = 0xF80759
    static let COLOR_TAB_BAR_ACTIVE = 0xF80759
    static let COLOR_NAV_BAR_BG_1 = 0xFF4600
    static let COLOR_NAV_BAR_BG_2 = 0xFF8300
    static let COLOR_READ_MORE = 0x4CA0FF
    static let COLOR_BUTTON_BG = 0x003049
    static let COLOR_RADIO_BUTTON_BORDER = 0x5E5E5E
    
    static let COLOR_BACKGROUND_HOME_ICON = 0xF0F0F0
    static let COLOR_BACKGROUND_ICON_HOME_ACTIVE = 0xED3878
    
    static let COLOR_BACKGROUND_CHAT = 0x849ebf
    
    //  Layout
    static let TAB_BAR_HEIGHT: CGFloat = 3
    
    //  Value
    
    static var OPEN_TYPE = ""
    
    
    //  Limit
    
    static let MIN_AGE = 18
    
    //  Notification
    
    static let NOTIFICATION_REFRESH_CHAT = "NOTIFICATION_REFRESH_CHAT"
    static let NOTIFICATION_REFRESH_HOME = "NOTIFICATION_REFRESH_HOME"
    
    //  Validate
    
    static let SHOW_ALERT_VALIDATE = true
    static var SHOW_TUTORAIL = false
    static var IS_CASULT = false
    static var IS_BACK_TO_CHAT = false
    
    //  Currency
    
    static var CURRENCY_SYMBOL = "THB"
    static var CURRENCY_VALUE = 1.0
    static var CURRENCY_LIST: [(title: String, value: Double)]!
    
    //  Language
    
    static let LANGUAGE = ["ไทย", "English", "中国"]
    
    //  Type map
    
    static var TYPE_CARD_VIEW = 0
    static var TYPE_DESC = 0
    
    //  Sort
    
    static var CATEGORY_ID = "-1"
    static var PRODUCT_PRICE_START = 0
    static var PRODUCT_PRICE_END = 0
    static var PRODUCT_SORT = "1"
    
    //  Longdo map
    static let API_KEY_LONGDOMAP = "mhelpme"
    
    //  length
    static let LENGTH = 2
}
