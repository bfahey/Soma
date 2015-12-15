//
//  RadioPlayer.swift
//  Example
//
//  Created by Blaine Fahey on 12/14/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import Foundation
import AVFoundation

class RadioPlayer {
    static let sharedInstance = RadioPlayer()
    private var player = AVPlayer()
    
    var isPlaying: Bool {
        return player.rate.isNormal
    }
    
    private init () {}
    
    func play(url: NSURL) {
        player = AVPlayer.init(URL: url)
        player.play()
    }
    
    func pause() {
        player.pause()
    }
}