//
//  ValidationHelper.swift
//  LuckyDraw
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import Foundation

class ValidationHelper: NSObject {
    
    static func isEmail(_ text: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return test.evaluate(with: text)
    }
    
    static func isPassword(_ text: String) -> Bool {
        //        let regex = "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,15}"
        //        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return text.count >= 6//test.evaluateWithObject(text)
    }
    
    static func isPhone(_ text: String) -> Bool {
        //        let regex = "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,15}"
        //        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return text.count >= 9//test.evaluateWithObject(text)
    }
    
    static func isText(_ text: String) -> Bool {
        //        let regex = "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,15}"
        //        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return text.count >= 1//test.evaluateWithObject(text)
    }
    
//    static func isCitizenNo(_ text: String) -> Bool {
//        var isValid = false
//        if text.count == 13 {
//            var sum = 0;
//            for i in 0..<12 {
//                sum += (Int(text[i])! * (13 - i))
//            }
//            let lastDigit = (11 - sum % 11) % 10
//            isValid = Int(text[12]) == lastDigit
//        }
//        return isValid
//    }
    
}
