//
//  Audio.swift
//  CinemaTix
//
//  Created by Eky on 04/12/23.
//

import Foundation
import AVFoundation

class Audio {
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    func loadNotification() {
        if let path = Bundle.main.path(forResource: "notification", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
            } catch {
                print("Error loading audio file: \(error.localizedDescription)")
            }
        }
    }
    
    func playAudio() {
        audioPlayer?.play()
    }


}
