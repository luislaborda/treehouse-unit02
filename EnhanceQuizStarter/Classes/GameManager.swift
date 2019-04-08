//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Luis Laborda on 4/7/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//
import UIKit

class GameManager {
    
    let questionsPerRound = 4
    var questionDictionary: Question?
    
    let trivia: Trivia?
    
    // Game scoring
    var numQuestionsAsked = 0
    var correctQuestions = 0
    
    init() {
        trivia = Trivia.init()
    }

    //MARK: - Game Methods
    /**
     Get one question from the pool
     
     - Parameter: nil
     
     - Return: Dictionary of one question from the pool
    */
    func newQuestionFromPool() -> Question? {
        guard let triviaQuestion = trivia!.loadNewTriviaQuestion() else {
            return nil
        }
        questionDictionary = triviaQuestion
        return questionDictionary
    }
    
    /**
     checks for correct answer and adds 1 point to correctQuestions stored property
     
     - Parameter: label - is the text in the label of the selected button
     
     - Return: Bool - True if the answer is correct, otherwise false
    */
    func checkAnswer(button label: String) -> Bool {
        numQuestionsAsked += 1
        guard let answer = questionDictionary?.answser else {
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
        trivia!.resetTrivia()
    }

}
