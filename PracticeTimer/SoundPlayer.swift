//
//  soundPlayer.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 10/05/2022.
//

import SwiftUI
import AVKit

struct SoundPlayer {
    var player: AVAudioPlayer?
    
    init() {
        guard let url = Bundle.main.url(forResource: "shortBeep", withExtension: "wav") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                guard let player = player else { return }
                
                player.prepareToPlay()

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            } catch let error {
                print(error.localizedDescription)
            }
    }
    
    mutating func play(beep: String){
        guard let url = Bundle.main.url(forResource: beep, withExtension: "wav") else { return }

            do {
//                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
    }
    
}


