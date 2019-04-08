//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by Luis Laborda on 4/8/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import AudioToolbox

struct SoundManager {
    
    // Sound
    var gameSound: SystemSoundID = 0
    
    /**
     Announces start of the game by making a sound
     
     - Paremeter: nil
     
     - Return: nil
     */
    mutating func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }


    public func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}
