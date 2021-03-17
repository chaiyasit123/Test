//
//  MCrypt.swift
//  APSeller
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import Foundation
//import CryptoSwift

class MCrypt {
    
    static let key = "objectoop1234567"
    static let iv = "1234567objectoop"
    
    static func encode(_ text: String) throws -> String {
        /*let data = text.dataUsingEncoding(NSUTF8StringEncoding)
        let enc = try AES(key: key, iv: iv, blockMode:.CBC).encrypt(data!.arrayOfBytes())
        let encData = NSData(bytes: enc, length: Int(enc.count))
        let base64String: String = encData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
        let result = String(base64String)
        return result*/
//        let data = text.data(using: String.Encoding.utf8)
//        
//        let base64String: String = (data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
//        let result = String(base64String)
//        return result!
        return text
    }
    static func decode(_ text: String) throws -> String {
        /*let data = NSData(base64EncodedString: text, options: NSDataBase64DecodingOptions(rawValue: 0))
        let dec = try AES(key: key, iv: iv, blockMode:.CBC).decrypt(data!.arrayOfBytes(), padding: PKCS7())
        let decData = NSData(bytes: dec, length: Int(dec.count))
        let result = NSString(data: decData, encoding: NSUTF8StringEncoding)
        return String(result!)*/
//        var base64Decoded = NSData(base64Encoded: text, options: NSData.Base64DecodingOptions(rawValue: 0))
//        if base64Decoded == nil {
//            base64Decoded = NSData()
//        }
//        let result = NSString(data: base64Decoded! as Data, encoding: String.Encoding.utf8.rawValue)! as String
//        NSLog("\(result)")
//        return result
        return text
    }
}
