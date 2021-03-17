//
//  PlayerView.swift
//  M Help Me
//
//  Created by Tanawat Suriyachai on 2/12/2561 BE.
//  Copyright © 2561 S-planet. All rights reserved.
//

import UIKit
import AVKit;
import AVFoundation;

class PlayerView: UIView {
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self;
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer;
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player;
        }
        set {
            playerLayer.player = newValue;
        }
    }
}
