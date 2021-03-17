//
//  NumberExtension.swift
//  MasterTemplate
//
//  Created by S-Planet iOS on 5/15/2560 BE.
//  Copyright © 2560 S-Planet. All rights reserved.
//

import Foundation

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
