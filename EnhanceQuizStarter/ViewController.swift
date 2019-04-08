//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let gameManager: GameManager = GameManager()
    
    // MARK: - Outlets
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var scoring: UILabel!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    var questionNumber: Int = 0
    
    override func viewDidLoad() {
        // Display play again button
        playAgainButton.isHidden = false
        
        super.viewDidLoad()
        newQuestion()
        gameManager.playGameStartSound()
    }
    
    
    // displays new question
    func newQuestion() {
        let questionDictionary = gameManager.newQuestionFromPool()
        questionField.text = questionDictionary["Question"] as? String
        
        let answers = questionDictionary["Answers"]! as? [String]
        firstBtn.setTitle(answers![0], for: .normal)
        firstBtn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        secondBtn.setTitle(answers![1], for: .normal)
        secondBtn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        thirdBtn.setTitle(answers![2], for: .normal)
        thirdBtn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        fourthBtn.setTitle(answers![3], for: .normal)
        fourthBtn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        enableAllButtons()
        
        scoring.isHidden = true

        playAgainButton.isHidden = true
    }
    
    // display the final score
    func displayScore() {
        scoring.isHidden = false
        scoring.text = "Correct Answers: \(gameManager.correctQuestions)"
    }
    
    // End of round
    func gameOver() {
        questionField.isHidden = true
        firstBtn.isHidden = true
        secondBtn.isHidden = true
        thirdBtn.isHidden = true
        fourthBtn.isHidden = true
        
        displayScore()
        playAgainButton.isHidden = false
    }
    
    /**
     Displays the if the selected answer is correct or not
     
     - Parameter: text - informs the user if selected answer is correct or not
     
     - Return: nil
    */
    fileprivate func results(text: String) {
        scoring.isHidden = false
        scoring.text = text
        
        loadNextQuestion()
    }
    
    
    
    // MARK: - Helper methods
    
    /**
     helper to automatically load or end the game
     
     - Paremeter: nil
     
     - Return: nil
     */
    fileprivate func loadNextQuestion() {
        if !self.gameManager.isEndOfRound() {
            self.loadNextRound(delay: 2, endGame: false)
        } else {
            self.loadNextRound(delay: 2, endGame: true)
        }
    }
    /**
     helper method to dispatch a method after n number of seconds
     
     - Paremeter: Seconds - number of seconds will wait until it dispath/triggers a method
     - Parameter: endGame - Boolean to know if is the end of the round
     
     - Return: nil
     */
    fileprivate func loadNextRound(delay seconds: Int, endGame:Bool) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            if !endGame {
                self.newQuestion()
            } else {
                self.gameOver()
            }
        }
    }
    
    // disables all the buttons with tag 1 through 4
    fileprivate func disableAllButtons(except tag:Int) {
        // Disable all other buttons to prevent tapping multiple ones
        for tagValue in 1...4 {
            if tagValue != tag {
                let tempBtn = self.view.viewWithTag(tagValue) as! UIButton
                tempBtn.isEnabled = false
            }
        }
    }
    
    // enables all the buttons with tag 1 through 4
    fileprivate func enableAllButtons() {
        for tagValue in 1...4 {
            let tempBtn = self.view.viewWithTag(tagValue) as! UIButton
            tempBtn.isEnabled = true
        }
    }
    
    
    // MARK: - Actions
    
    // check if selected answer is correct
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        disableAllButtons(except: sender.tag)
        
        let title = sender.titleLabel?.text
        let isCorrectAnswer = gameManager.checkAnswer(button: title!)
        
        // Correct Answer
        if isCorrectAnswer {
            UIView.animate(withDuration: 0.2, animations: {
                sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }) { _ in
                self.results(text: "Correct")
            }
        } // Wrong Answer
        else {
            UIView.animate(withDuration: 0.2, animations: {
                sender.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            }) { _ in
                self.results(text: "No Dice!!")
            }
        }
    }
    
    // starts a new round of questions
    @IBAction func playAgain(_ sender: UIButton) {
        gameManager.reset()
        newQuestion()
        
        questionField.isHidden = false
        firstBtn.isHidden = false
        secondBtn.isHidden = false
        thirdBtn.isHidden = false
        fourthBtn.isHidden = false
    }
}