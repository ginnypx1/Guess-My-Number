//
//  ViewController.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 4/8/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets

    @IBOutlet weak var strikeCountLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var winLoseLabel: UILabel!
    
    // MARK: - Game variables
    
    var randomNumber: Int = Int(arc4random_uniform(10)) + 1
    
    var strikes: Int = 0
    var userGuess: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set text field delegate
        guessTextField.delegate = self
        
        // clear label fields
        strikeCountLabel.text = ""
        hintLabel.text = ""
        winLoseLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // subscribe to keyboard notifications
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // unsubscribe to keyboard notifications
        unsubscribeToKeyboardNotifications()
    }
    
    // MARK: - Dismiss the keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guessTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Play a turn
    
    func playTurn(_ guess: Int) {
        
        //if randomNumber == userGuess
        if randomNumber == userGuess {
            // display win in winLose field
            winLoseLabel.text = "You win!"
            
        //else if strikes == 2
        } else if strikes == 2 {
            // display lose in winLose field
            strikeCountLabel.text = "My number was \(randomNumber)"
            winLoseLabel.text = "You lose!"
            
        } else {
            strikes += 1
            strikeCountLabel.text = "Strikes: \(strikes)"
            // if randomNumber > userGuess
            if randomNumber > userGuess {
                hintLabel.text = "Hint: guess higher!"
            } else {
                hintLabel.text = "Hint: guess lower!"
            }
        }
    }
    
    // MARK: - Guess

    @IBAction func guess(_ sender: Any) {
        // grab the textField's input and set as myGuess
        if let guess = guessTextField.text {
            if let intGuess = Int(guess) {
                userGuess = intGuess
            } else {
                hintLabel.text = "Please enter a number 1-10"
            }
        } else {
            hintLabel.text = "Please enter a number 1-10"
        }
        
        // clear StrikeCount and hint
        strikeCountLabel.text = ""
        hintLabel.text = ""
        guessTextField.text = ""
        guessTextField.placeholder = "5"
        
        // playTurn(myguess)
        playTurn(userGuess)
    }
    
    // MARK: - Reset for new game

    @IBAction func playAgain(_ sender: Any) {
        
        // reset game variables
        randomNumber = Int(arc4random_uniform(10)) + 1
        strikes = 0
        
        // clear all fields
        guessTextField.text = ""
        strikeCountLabel.text = ""
        hintLabel.text = ""
        winLoseLabel.text = ""
    }
}

