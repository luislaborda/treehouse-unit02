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
    
    let qa = QuestionsProvider()
    
    // Keep track of selected questions to avoid repeat
    var questionsAsked = Set<Int>()
    var indexOfSelectedQuestion = 0
    
    
    // MARK: -
    
    /**
     Initialization
    */
    init() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: qa.questions.count)
    }

    /**
     Obtains a new question at random without duplicating
     
     - Parameter: nil
     
     - Return: Dictionary[String: Any]
              A question from QuestionsProvider Model
    */
    public func loadNewTriviaQuestion() -> Question? {
        
        // Whether or not we exaust the questions
        if self.questionsLeft() {
            
            // loop to avoid selecting the same question
            while questionsAsked.contains(indexOfSelectedQuestion) {
                indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: qa.questions.count)
            }
            
            // Add to the questions asked set
            questionsAsked.insert(indexOfSelectedQuestion)
            
            return qa.questions[indexOfSelectedQuestion]
        }
        
        // return nil id there are no questions left for the round
        return nil
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
        if questionsAsked.count <= qa.questions.count {
            return true
        }
        return false
    }
}
