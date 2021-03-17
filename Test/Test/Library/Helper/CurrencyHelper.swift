//
//  CurrencyHelper.swift
//  LuckyDraw
//
//  Created by Tanawat Suriyachai on 3/6/2561 BE.
//  Copyright © 2561 Tanawat Suriyachai. All rights reserved.
//

import Foundation

class CurrencyHelper: NSObject {
    
    static func convert(_ price: String) -> String {
        let format = (Constant.CURRENCY_SYMBOL == "THB" ? "%.0f" : "%.2f")
        
        let convertPrice = Double(price)! * Constant.CURRENCY_VALUE
        return String.localizedStringWithFormat(format, convertPrice)
    }
    
}
