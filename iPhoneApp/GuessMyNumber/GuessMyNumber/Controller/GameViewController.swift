//
//  GameViewController.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 4/8/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet var directionLabels: [UILabel]!
    
    @IBOutlet weak var guessTextField: UITextField!
    
    // MARK: - Properties
    
    var resultsView: ResultsView!
    var strikesView: StrikesView!
    var blackoutView: UIView!
    
    var soundManager: SoundManager = SoundManager()
    var game: Game!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.guessTextField.delegate = self
        
        addTapGestureRecognizer()
        
        AnimationManager.fadeInDirections(for: directionLabels)
        game = Game()
        print("\(game.randomNumber) is the winner")
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
    
    // MARK: Play a turn
    
    func playTurn() {
        if game.randomNumber == game.userGuess {
            game.didWin = true
            activateResults()
        } else if game.strikes == 2 {
            activateResults()
        } else {
            game.strikes += 1
            showGameStatus()
        }
    }
    
    // MARK: - Guess

    @IBAction func guess(_ sender: Any) {
        if let guess = guessTextField.text {
            if let intGuess = Int(guess) {
                game.userGuess = intGuess
                playTurn()
            } else {
                Alerts.displayAlert(from: self)
            }
        } else {
            Alerts.displayAlert(from: self)
        }
        
        guessTextField.text = ""
        guessTextField.placeholder = "5"
    }
    
    // MARK: - Show Game Status
    
    func showGameStatus() {
        self.blackoutView = BlackoutView.create(in: self.view)
        self.view.addSubview(blackoutView)
        addStatusView()

        let dropHeight = (self.view.frame.size.height * 0.15)
        AnimationManager.animateViewPopdown(popdownView: self.strikesView, dropHeight: dropHeight)
    }
    
    func addStatusView() {
        if (strikesView != nil) {
            strikesView.removeFromSuperview()
        }
        strikesView = StrikesView.create(in: self.view, with: self.game) as! StrikesView
        
        strikesView.guessAgainButton.addTarget(self, action: #selector(guessAgainPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(strikesView)
    }
    
    // MARK: - Activate Win or Lose
    
    func activateResults() {
        self.blackoutView = BlackoutView.create(in: self.view)
        self.view.addSubview(blackoutView)
        addResultsView()
        
        let dropHeight = (self.view.frame.size.height * 0.15)
        AnimationManager.animateViewPopdown(popdownView: self.resultsView, dropHeight: dropHeight)
        
        soundManager.playWinSoundEffect(didWin: game.didWin)
    }
    
    func addResultsView() {
        if (resultsView != nil) {
            resultsView.removeFromSuperview()
        }
        resultsView = ResultsView.create(in: self.view, with: self.game) as! ResultsView
        
        resultsView.playAgainButton.addTarget(self, action: #selector(playAgainPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(resultsView)
    }
    
    // MARK: - Play Again
    
    @objc func playAgainPressed(sender: UIButton) {
        soundManager.stopSound()
        AnimationManager.removePopdown(self.resultsView, blackoutView: self.blackoutView)
        self.blackoutView = nil
        self.resultsView = nil
        self.game = Game()
    }
    
    @objc func guessAgainPressed(sender: UIButton) {
        AnimationManager.removePopdown(self.strikesView, blackoutView: self.blackoutView)
        self.blackoutView = nil
        self.strikesView = nil
    }
}
