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
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // default sound id
    var sound = SoundManager.init(gameSound: 1000)

    var questionNumber: Int = 0
    
    override func viewDidLoad() {
        // Display play again button
        playAgainButton.isHidden = false

        sound.playGameStartSound()
        
        super.viewDidLoad()
        newQuestion()
        
    }
    
    
    /// Displays new question
    func newQuestion() {
        guard let questionObject = gameManager.newQuestionFromPool() else {
            questionField.text = "Unable to load any more questions"
            return
        }
        
        questionField.text = questionObject.question
        
        let answers = questionObject.possibleAnswers
        firstButton.setTitle(answers[0], for: .normal)
        firstButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        secondButton.setTitle(answers[1], for: .normal)
        secondButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        thirdButton.setTitle(answers[2], for: .normal)
        thirdButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        fourthButton.setTitle(answers[3], for: .normal)
        fourthButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        enableAllButtons()
        
        scoring.isHidden = true

        playAgainButton.isHidden = true
    }
    
    /// Display the final score
    func displayScore() {
        scoring.isHidden = false
        scoring.text = "Correct Answers: \(gameManager.correctQuestions)"
    }
    
    /// End of round
    func gameOver() {
        questionField.isHidden = true
        firstButton.isHidden = true
        secondButton.isHidden = true
        thirdButton.isHidden = true
        fourthButton.isHidden = true
        
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
    
    /**
     Disables all the buttons with tag 1 through 4
     
     - Parameter: tag - index of the button indicated in the tag stored property
     
     - Return: nil
    */
    fileprivate func disableAllButtons(except tag:Int) {
        // Disable all other buttons to prevent tapping multiple ones
        for tagValue in 1...4 {
            if tagValue != tag {
                let tempBtn = self.view.viewWithTag(tagValue) as! UIButton
                tempBtn.isEnabled = false
            }
        }
    }
    
    /**
     Enables all the buttons with tag 1 through 4
     
     - Parameter: nil
     
     - Return: nil
     */
    fileprivate func enableAllButtons() {
        for tagValue in 1...4 {
            let tempBtn = self.view.viewWithTag(tagValue) as! UIButton
            tempBtn.isEnabled = true
        }
    }
    
    
    // MARK: - Actions
    
    /// Check if selected answer is correct
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        guard let title = sender.titleLabel?.text else {
            return
        }
        
        disableAllButtons(except: sender.tag)
        
        let isCorrectAnswer = gameManager.checkAnswer(button: title)
        
        // Animates the buttons background color
        if isCorrectAnswer {
            sound.gameSound = 1106
            sound.playGameStartSound()
            UIView.animate(withDuration: 0.2, animations: {
                sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }) { _ in
                self.results(text: "Correct")
            }
        } // Wrong Answer
        else {
            sound.gameSound = 1025
            sound.playGameStartSound()
            UIView.animate(withDuration: 0.2, animations: {
                sender.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            }) { _ in
                self.results(text: "No Dice!!")
            }
        }
    }
    
    /// Starts a new round of questions
    @IBAction func playAgain(_ sender: UIButton) {
        gameManager.reset()
        newQuestion()
        
        questionField.isHidden = false
        firstButton.isHidden = false
        secondButton.isHidden = false
        thirdButton.isHidden = false
        fourthButton.isHidden = false
    }
}
