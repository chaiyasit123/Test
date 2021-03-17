//
//  MapHelper.swift
//  M Help Me
//
//  Created by Tanawat Suriyachai on 13/11/2561 BE.
//  Copyright © 2561 S-planet. All rights reserved.
//

import Foundation

class MapHelper: NSObject {
    
    static func deg2rad(_ deg:Double) -> Double {
        return deg * .pi / 180
    }
    
    static func rad2deg(_ rad:Double) -> Double {
        return rad * 180.0 / .pi
    }
    
    static func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta))
        dist = acos(dist)
        dist = rad2deg(dist)
        dist = dist * 60 * 1.1515
        if (unit == "K") {
            dist = dist * 1.609344
        }
        else if (unit == "N") {
            dist = dist * 0.8684
        }
        return dist
    }
    
}
