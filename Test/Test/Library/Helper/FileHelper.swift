//
//  FileHelper.swift
//  LuckyDraw
//
//  Created by Tanawat Suriyachai on 04/17/2560 BE.
//  Copyright (c) 2560 S-Planet. All rights reserved.
//

import Foundation

class FileHelper: NSObject {

    static func getTextFromFile(_ fileName: String, ext: String) -> String {
        guard let path = Bundle.main.path(forResource: fileName, ofType: ext) else {
            return ""
        }
        do {
            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            return content
        } catch _ as NSError {
            return ""
        }
    }
    
    static func getTextFromDocument(_ fileName: String, ext: String) -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        //  File browser for checking
        /*do {
            let fileManager = FileManager.default
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            for i in 0..<fileURLs.count {
                NSLog("file \(fileURLs[i].absoluteString)")
            }
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }*/
        
        let path = documentsURL.appendingPathComponent("\(fileName).\(ext)")
        do {
            let content = try String(contentsOf: path, encoding: String.Encoding.utf8)
            return content
        } catch let e as NSError {
            print(e.localizedDescription)
            return ""
        }
    }
    
    static func isExistInDocument(_ fileName: String, ext: String) -> Bool {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        //  File browser for checking
        /*do {
         let fileManager = FileManager.default
         let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
         for i in 0..<fileURLs.count {
         NSLog("file \(fileURLs[i].absoluteString)")
         }
         } catch {
         print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
         }*/
        
        let fileUrl = documentsURL.appendingPathComponent("\(fileName).\(ext)")
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: fileUrl.path)
    }
    
}

