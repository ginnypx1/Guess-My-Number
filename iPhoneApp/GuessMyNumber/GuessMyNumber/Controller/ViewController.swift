//
//  ViewController.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 4/8/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var guessTextField: UITextField!
    
    // MARK: - Properties
    
    var winView: WinView!
    var strikesView: StrikesView!
    var blackoutView: UIView!
    
    var soundManager: SoundManager = SoundManager()
    
    var game: Game!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set text field delegate
        self.guessTextField.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        // create a game
        game = Game()
        print("\(game.randomNumber) is the winner")
    }
    
    // MARK: - Keyboard Notifications
    
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
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        guessTextField.endEditing(true)
        return false
    }
    
    @objc func didTapView(){
        guessTextField.endEditing(true)
    }
    
    // MARK: Play a turn
    
    func playTurn() {
        //if randomNumber == userGuess
        if game.randomNumber == game.userGuess {
            // activate Win
            activateWin(didWin: true)
            
        //else if strikes == 2
        } else if game.strikes == 2 {
            // activate Loss
            activateWin(didWin: false)
            
        } else {
            game.strikes += 1
            showGameStatus()
        }
    }
    
    // MARK: - Guess

    @IBAction func guess(_ sender: Any) {
        // grab the textField's input and set as game.userGuess
        if let guess = guessTextField.text {
            if let intGuess = Int(guess) {
                game.userGuess = intGuess
            } else {
                Alerts.displayAlert(from: self)
            }
        } else {
            Alerts.displayAlert(from: self)
        }
        
        guessTextField.text = ""
        guessTextField.placeholder = "5"
        
        // playTurn()
        playTurn()
    }
    
    // MARK: - Show Game Status
    
    func showGameStatus() {
        // create black background
        createBlackBackground()
        // popdown view slides in from top of screen
        addStatusView()
        // drop down the popdownView
        let dropHeight = (self.view.frame.size.height * 0.15)
        AnimationManager.animateViewPopdown(popdownView: self.strikesView, dropHeight: dropHeight)
    }
    
    func addStatusView() {
        // make sure there's not already a popdown view on screen
        if (strikesView != nil) {
            strikesView.view.removeFromSuperview()
        }
        
        let viewWidth = self.view.frame.size.width >= self.view.frame.height ? (self.view.frame.size.height * 0.9) : (self.view.frame.size.width * 0.8)
        let viewHeight = self.view.frame.size.width >= self.view.frame.height ? (self.view.frame.size.height * 0.7) : (self.view.frame.size.height * 0.5)
        
        // create the status view
        strikesView = StrikesView(frame: CGRect(x: (self.view.frame.size.width-viewWidth)/2 , y: -800, width: viewWidth, height: viewHeight))
        
        // Display game status
        strikesView.strikeCountLabel.text = "Strikes: \(game.strikes)"
        strikesView.hintLabel.text = (game.randomNumber < game.userGuess) ? "Guess lower!" : "Guess higher!"
        
        // allow user guess Again
        strikesView.guessAgainButton.addTarget(self, action: #selector(guessAgainPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(strikesView)
    }
    
    // MARK: - Activate Win or Lose
    
    func activateWin(didWin: Bool) {
        // create black background
        createBlackBackground()
        // popdown view slides in from top of screen
        addWinView(didWin: didWin)
        
        // drop down the popdownView
        let dropHeight = (self.view.frame.size.height * 0.15)
        AnimationManager.animateViewPopdown(popdownView: self.winView, dropHeight: dropHeight)
        
        // play sound
        soundManager.playWinSoundEffect(didWin: didWin)
    }
    
    func addWinView(didWin: Bool) {
        // make sure there's not already a popdown view on screen
        if (winView != nil) {
            winView.view.removeFromSuperview()
        }
        
        let viewWidth = self.view.frame.size.width >= self.view.frame.height ? (self.view.frame.size.height * 0.8) : (self.view.frame.size.width * 0.8)
        let viewHeight = self.view.frame.size.width >= self.view.frame.height ? (self.view.frame.size.height * 0.8) : (self.view.frame.size.height * 0.8)
        
        // create the win view
        winView = WinView(frame: CGRect(x: (self.view.frame.size.width-viewWidth)/2 , y: -800, width: viewWidth, height: viewHeight))
        
        // State win or lose
        winView.winLoseLabel.text = didWin ? "You Win!" : "You Lose!"
        
        if didWin {
            let myScene = SCNScene()
            let particleNode = SCNNode()
            let particleSystem = SCNParticleSystem(named: "Confetti", inDirectory: "")
            particleNode.addParticleSystem(particleSystem!)
            myScene.rootNode.addChildNode(particleNode)
            winView.sceneKitView.scene = myScene
        }
        
        // allow user to select play again
        winView.playAgainButton.addTarget(self, action: #selector(playAgainPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(winView)
    }
    
    // MARK: - Play Again
    
    @objc func playAgainPressed(sender: UIButton) {
        // stop audio
        soundManager.stopSound()
        
        // slide popup view up off screen
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.winView.center.y -= 900
        }, completion: { finished in
            // remove the superviews and start a new game
            self.winView.removeFromSuperview()
            self.blackoutView.removeFromSuperview()
        })
        
        // create a new game
        self.game = Game()
    }
    
    @objc func guessAgainPressed(sender: UIButton) {
        // slide popup view up off screen
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.strikesView.center.y -= 900
        }, completion: { finished in
            // remove the superviews and start a new game
            self.strikesView.removeFromSuperview()
            self.blackoutView.removeFromSuperview()
        })
    }
    
    // MARK: - Blackout View
    
    func createBlackBackground() {
        // grey out the game board when superview pops up
        blackoutView = UIView(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height))
        blackoutView.backgroundColor = UIColor.gray
        blackoutView.alpha = 0.5
        self.view.addSubview(blackoutView)
    }
    
}

