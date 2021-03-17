//
//  TimeHelper.swift
//  LuckyDraw
//
//  Created by Tanawat Suriyachai on 5/28/2561 BE.
//  Copyright © 2561 Tanawat Suriyachai. All rights reserved.
//

import Foundation

class TimeHelper: NSObject {
    
    static func seconds2Timestamp(_ seconds: Int = 0) -> String {
        let mins:Int = seconds/60
        let secs:Int = seconds%60
        
        let strTimestamp:String = ((mins<10) ? "0" : "") + String(mins) + ":" + ((secs<10) ? "0" : "") + String(secs)
        return strTimestamp
    }
    
}
