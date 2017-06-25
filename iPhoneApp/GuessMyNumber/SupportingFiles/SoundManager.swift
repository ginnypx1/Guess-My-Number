//
//  SoundManager.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 6/25/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import AVFoundation
import UIKit

// MARK: - Sound Manager

class SoundManager {
    
    // MARK: - Properties
    
    var audioPlayer: AVAudioPlayer!
    
    // MARK: - Sound Effects
    
    func playWinSoundEffect(didWin: Bool) {
        let winSound = Bundle.main.url(forResource: "small-crowd", withExtension: "mp3")
        let loseSound = Bundle.main.url(forResource: "sad-trombone", withExtension: "mp3")
        
        do {
            let sound = didWin ? winSound : loseSound
            self.audioPlayer = try AVAudioPlayer(contentsOf: sound!)
            guard let player = self.audioPlayer else { return }
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Stop Sound
    
    func stopSound() {
        guard let player = self.audioPlayer else { return }
        player.stop()
    }
}
