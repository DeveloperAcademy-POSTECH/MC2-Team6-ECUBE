//
//  VoicemailPlayerViewModel.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/18.
//

import Foundation
import AVFoundation

class VoicemailPlayer: ObservableObject {
    
    var player: AVPlayer?
    
    func PlaySound(voicemailURL: URL) {
        self.player = AVPlayer(url: voicemailURL)
    }
    
}
