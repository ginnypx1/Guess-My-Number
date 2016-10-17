//
//  ViewController.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 8/4/16.
//  Copyright © 2016 GhostBirdGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var StrikeCount: UILabel!
    @IBOutlet weak var hint: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var winLose: UILabel!
    
    // MARK: - game variables

    var randomNumber: Int = Int(arc4random_uniform(11)) + 1
    var strikes: Int = 0
    var myGuess: Int = 0
    
    // MARK: - auto Apple
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // conform to UITextFieldDelegate to toggle keyboard
        self.textField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - game loop
    
    func playTurn(_ guess: Int) {
        // dismiss the keyboard
        textField.resignFirstResponder()
        //if randomNumber == myGuess
        if randomNumber == myGuess {
           // display win in winLose field
            winLose.text = "You win!"
        //else if strikes == 2
        } else if strikes == 2 {
            // display lose in winLose field
            winLose.text = "You lose!"
        } else {
            // if randomNumber > myGuess
            if randomNumber > myGuess {
                strikes += 1
                StrikeCount.text = "Strikes: \(strikes)"
                hint.text = "Hint: guess higher!"
            } else {
                strikes += 1
                StrikeCount.text = "Strikes: \(strikes)"
                hint.text = "Hint: guess lower!"
            }
        }
    }
    
    //MARK - button press

    // PUSH THE GUESS BUTTON
    @IBAction func guess(_ sender: AnyObject) {
        // grab the textField's input and set as myGuess
        if let guess = textField.text {
            if let intGuess = Int(guess) {
                myGuess = intGuess
            } else {
                hint.text = "Please enter a number 1-10"
            }
        } else {
            hint.text = "Please enter a number 1-10"
        }
        // clear StrikeCount and hint
        StrikeCount.text = " "
        hint.text = " "
        // playTurn(myguess)
        playTurn(myGuess)
    }

    //PUSH THE PLAY AGAIN BUTTON
    @IBAction func playAgain(_ sender: AnyObject) {
        // reset game variables
        randomNumber = Int(arc4random_uniform(11)) + 1
        strikes = 0
        // clear all fields
        textField.text = ""
        StrikeCount.text = " "
        hint.text = " "
        winLose.text = " "
    }
    
    // MARK: - Dismiss the keyboard
    
    // when touched outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

