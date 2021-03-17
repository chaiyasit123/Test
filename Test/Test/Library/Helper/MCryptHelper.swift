//
//  MCryptHelper.swift
//  LuckyDraw
//
//  Created by Tanawat Suriyachai on 4/25/2560 BE.
//  Copyright © 2560 S-Planet. All rights reserved.
//

import Foundation

class MCryptHelper: NSObject {
    
    static func encode(_ str: String) -> String {
        let string = str as NSString
        
        //  Sha1
//        let data = Constant.ENCODE_KEY.data(using: String.Encoding.utf8)!
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
//        }
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        let key = hexBytes.joined() as NSString
//        
//        let strLen = string.length
//        let keyLen = key.length
//        var j = 0
//        var hash = ""
//        for i in 0..<strLen {
//            let ordStr = string.substring(with: NSMakeRange(i, 1)).asciiArray[0]
//            if j == keyLen {
//                j = 0
//            }
//            let ordKey = key.substring(with: NSMakeRange(j, 1)).asciiArray[0]
//            j += 1
//            
//            let dechex = String(ordStr + ordKey, radix: 16)
//            let temp = String(Int(dechex, radix: 16)!, radix: 36)
//            
//            hash += String(temp.characters.reversed())
//        }
        return string as String
    }
    
}
