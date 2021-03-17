//
//  StringHelper.swift
//  LuckyDraw
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import UIKit

extension String {
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func localized() -> String {
        let appPreference = AppPreference()
        let language = appPreference.getValueString(AppPreference.language)
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        //return NSLocalizedString(self, comment: "")
    }
    
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
    
    func getYoutubeFormattedDuration() -> String {
        var addExtraZero = false
        var formattedDuration = self.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with: ":")
        if formattedDuration.contains("M") {
            formattedDuration = formattedDuration.replacingOccurrences(of: "M", with: ":")
        } else {
            formattedDuration = "00:" + formattedDuration
        }
        if formattedDuration.contains("S") {
            formattedDuration = formattedDuration.replacingOccurrences(of: "S", with: "")
        } else {
            addExtraZero = true
        }
        
        let components = formattedDuration.components(separatedBy: ":")
        var duration = ""
        for component in components {
            duration = duration.count > 0 ? duration + ":" : duration
            if component.count < 2 {
                duration += ("0" + component)
                continue
            }
            duration += component
        }
        
        if addExtraZero {
            duration += "0"
        }
        
        return duration
    }
    
    func phoneFormat() -> String {
        if self.isEmpty || self.count < 10 {
            return self
        }
        let start = index(startIndex, offsetBy: 0)
        let end = index(startIndex, offsetBy: 3)
        let range = start..<end
        
        let start2 = index(startIndex, offsetBy: 3)
        let end2 = index(startIndex, offsetBy: 6)
        let range2 = start2..<end2
        
        let start3 = index(startIndex, offsetBy: 6)
        let end3 = index(startIndex, offsetBy: 10)
        let range3 = start3..<end3
        
        let s = String(format: "%@-%@-%@"
            , substring(with: range)
            , substring(with: range2)
            , substring(with: range3)
        )
        return s
    }
    
    func citizenNoFormat() -> String {
        if self.isEmpty || self.count < 13 {
            return self
        }
        let start = index(startIndex, offsetBy: 0)
        let end = index(startIndex, offsetBy: 1)
        let range = start..<end
        
        let start2 = index(startIndex, offsetBy: 1)
        let end2 = index(startIndex, offsetBy: 5)
        let range2 = start2..<end2
        
        let start3 = index(startIndex, offsetBy: 5)
        let end3 = index(startIndex, offsetBy: 10)
        let range3 = start3..<end3
        
        let start4 = index(startIndex, offsetBy: 10)
        let end4 = index(startIndex, offsetBy: 12)
        let range4 = start4..<end4
        
        let start5 = index(startIndex, offsetBy: 12)
        let end5 = index(startIndex, offsetBy: 13)
        let range5 = start5..<end5
        
        let s = String(format: "%@-%@-%@-%@-%@"
            , substring(with: range)
            , substring(with: range2)
            , substring(with: range3)
            , substring(with: range4)
            , substring(with: range5)
        )
        return s
    }
    
    func rePhoneFormat() -> String {
        return self.replacingOccurrences(of: "-", with: "")
    }

    func reCitizenNoFormat() -> String {
        return self.replacingOccurrences(of: "-", with: "")
    }
    
//    subscript (i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//
//    subscript (i: Int) -> String {
//        return String(self[i] as Character)
//    }
    
    subscript (r: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: r.lowerBound)
        let end = self.index(start, offsetBy: r.upperBound - r.lowerBound)
        return String(self[start..<end])
    }
    
    func simpleDate(_ dateFormat: String = "dd MMMM ") -> String {
        if self.contains("0000-00-00") {
            return "-"
        }
        let appPreference = AppPreference()
        let language = appPreference.getValueString(AppPreference.language)
        
        var format = ""
        if self.count == 10 {
            format = "yyyy-MM-dd"
        } else if self.count == 16 {
            format = "yyyy-MM-dd HH:mm"
        } else if self.count == 19 {
            format = "yyyy-MM-dd HH:mm:ss"
        } else {
            format = "yyyy-MM-dd h:mm a"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        dateFormatter.locale = Locale(identifier: language)
        dateFormatter.dateFormat = dateFormat
//        var string = dateFormatter.string(from: date!)
        
        let id = (language == "th" ? Calendar.Identifier.buddhist : Calendar.Identifier.gregorian)
        let calendar = Calendar(identifier: id)
//        let components = calendar.dateComponents([.day , .month , .year], from: date!)
//        let year =  components.year!
//        string = "\(string)\(year)"
        dateFormatter.calendar = calendar
        var string = ""
        if date != nil {
            string = dateFormatter.string(from: date!)
        }
    
        return string
    }
    
    func day() -> String {
        var format = ""
        if self.count == 10 {
            format = "yyyy-MM-dd"
        } else if self.count == 16 {
            format = "yyyy-MM-dd HH:mm"
        } else {
            format = "yyyy-MM-dd HH:mm:ss"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.day], from: date!)
        let day =  components.day!
        let string = String(day)
        
        return string
    }
    
    func dateNow() -> String {
        var format = ""
        if self.count == 10 {
            format = "yyyy-MM-dd"
        } else if self.count == 16 {
            format = "yyyy-MM-dd HH:mm"
        } else {
            format = "yyyy-MM-dd HH:mm:ss"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        if date?.compare(Date()) == ComparisonResult.orderedDescending {
            return self.simpleDate()
        } else {
            return "date_now".localized()
        }
    }
    
    func encode(_ s: String) -> String {
        let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    func decode(_ s: String) -> String? {
        let data = s.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }

    func capitalizingFirstLetter() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func replaceEmpty() -> String {
        return self.isEmpty ? "-" : self
    }
    
    func replaceButtonEmpty() -> String {
        return self.isEmpty ? "exhaust_btn".localized() : self
    }
    
    func base64Encoded() -> String? {
        return data(using: .utf8 )?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func utf8DecodedString()-> String {
         let data = self.data(using: .utf8)
         if let message = String(data: data!, encoding: .nonLossyASCII){
                return message
          }
          return ""
    }

    func utf8EncodedString()-> String {
         let messageData = self.data(using: .nonLossyASCII)
         let text = String(data: messageData!, encoding: .utf8)
        return text!
    }
}
