//
//  Quiz.swift
//  EnhanceQuizStarter
//
//  Created by Luis Laborda on 4/7/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//
import UIKit
import GameKit

class Trivia {
    
    let trivia = QuestionsProvider()
    
    // Keep track of selected questions to avoid repeat
    var questionsAsked = Set<Int>()
    var indexOfSelectedQuestion = 0
    
    // MARK: -
    
    /**
     Initialization
    */
    init() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.questions.count)
    }

    /**
     Obtains a new question at random without duplicating
     
     - Parameter: nil
     
     - Return: Dictionary[String: Any]
              A question from QuestionsProvider Model
    */
    public func loadNewTriviaQuestion() -> [String: Any] {
        
        // Whether or not we exaust the questions
        if self.questionsLeft() {
            
            // loop to avoid selecting the same question
            while questionsAsked.contains(indexOfSelectedQuestion) {
                indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.questions.count)
            }
            
            // Add to the questions asked set
            questionsAsked.insert(indexOfSelectedQuestion)
            
            return trivia.questions[indexOfSelectedQuestion]
        }
        
        // reutns empty question
        return ["Question": ""]
    }
    
    
    /**
     Empties the set of already asked questions
     Used for a new round
     
     - Parameter: nil
     
     - Return: nil
    */
    func resetTrivia() {
        self.questionsAsked.removeAll()
    }
    
    // MARK: - File private Methods
    
    /**
     Checks to see whether or not we exaust the questions
     
     - Parameter: nil
     
     - Return: Bool
               Whether or not we exaust the questions
    */
    fileprivate func questionsLeft() -> Bool {
        if questionsAsked.count <= trivia.questions.count {
            return true
        }
        return false
    }
}
