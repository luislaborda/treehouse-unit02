//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Luis Laborda on 4/7/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//
import UIKit
import AudioToolbox

class GameManager: Trivia {
    
    let questionsPerRound = 4
    var questionDictionary: [String:Any]?
    
    // Game scoring
    var numQuestionsAsked = 0
    var correctQuestions = 0
    
    // Sound
    var gameSound: SystemSoundID = 0
    
    override init() {
        super.init()
        loadGameStartSound()
    }

    //MARK: - Game Methods
    /**
     Get one question from the pool
     
     - Parameter: nil
     
     - Return: Dictionary of one question from the pool
    */
    func newQuestionFromPool() -> [String:Any] {
        questionDictionary = loadNewTriviaQuestion()
        return questionDictionary!
    }
    
    /**
 
    */
    func checkAnswer(button label: String) -> Bool {
        numQuestionsAsked += 1
        guard let answer = questionDictionary!["CorrectAnswer"] as? String else {
            return false
        }
        
        if answer == label {
            correctQuestions += 1
            return true
        }
        
        return false
    }
    
    /**
     Evaluates if is the end of the round or not of the current game
     
     - Parameter: nil
     
     - Return: Bool - True if is the end of the round. False if is not
     */
    func isEndOfRound() -> Bool {
        if numQuestionsAsked == questionsPerRound {
            return true
        }
        return false
    }
    
    /**
     Indicates if the round of the game has ended or not
     
     - Parameter: nil
     
     - Returns: Bool -nIndicating if the round has ended or not
     */
    func reset() {
        numQuestionsAsked = 0
        correctQuestions = 0
        resetTrivia()
    }
    
    
    // MARK: - Sound Helper Methods
    /**
     Announces start of the game by making a sound
 
     - Paremeter: nil
     
     - Return: nil
    */
    fileprivate func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
}
