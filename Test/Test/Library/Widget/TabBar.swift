//
//  TabBar.swift
//  SaLakThai
//
//  Created by Jiratin Teean on 3/2/2564 BE.
//

import UIKit

@available(iOS 11.0, *)
class CustomTabBar: UITabBar {
        
     override func awakeFromNib() {
            super.awakeFromNib()
            layer.masksToBounds = true
            layer.cornerRadius = 20
            layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
      }
 }
