//
//  GuessMyNumberGameViewControllerTests.swift
//  GuessMyNumberTests
//
//  Created by Ginny Pennekamp on 9/7/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import XCTest
@testable import GuessMyNumber

class GuessMyNumberGameViewControllerTests: XCTestCase {
    
    var sut: GameViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard
            .instantiateViewController(
                withIdentifier: "GameViewController")
            as! GameViewController
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test outlets exist
    
    func test_HasDirectionLabels() {
        XCTAssertNotNil(sut.directionLabels)
    }
    
    func test_HasTwoDirectionLabels() {
        let count = sut.directionLabels.count
        XCTAssertEqual(count, 2)
    }
    
    func test_HasGuessTextField() {
        XCTAssertNotNil(sut.guessTextField)
    }
    
    // MARK: - Test properties exists
    
    func test_HasSoundManager() {
        XCTAssertNotNil(sut.soundManager)
    }
    
    // MARK: - Test ViewDidLoad loads info properly
    
    func test_Game_Inits_InViewDidLoad() {
        XCTAssertNotNil(sut.game)
    }
    
    func test_DirectionLabels_FadeIn_InViewDidLoad() {
        let alpha = sut.directionLabels[0].alpha
        let alpha1 = sut.directionLabels[1].alpha
        XCTAssertEqual(alpha, 1.0)
        XCTAssertEqual(alpha1, 1.0)
    }
    
    func test_enteringText_InGuessTextField_SetsUserGuess() {
        sut.guessTextField.text = "1"
        let enteredGuess = Int(sut.guessTextField.text!)
        sut.guess((Any).self)
        let userGuess = sut.game.userGuess
        XCTAssertEqual(userGuess, enteredGuess)
    }
    
    func test_guessTextField_resetsText() {
        sut.guessTextField.text = "1"
        sut.guess((Any).self)
        let resetText = sut.guessTextField.text
        XCTAssertEqual(resetText, "")
    }
    
    func test_guessTextField_resetsPlaceholderText() {
        sut.guessTextField.text = "1"
        sut.guess((Any).self)
        let placeholderText = sut.guessTextField.placeholder
        XCTAssertEqual(placeholderText, "5")
    }
    
    func test_playTurn_RecognizesWin() {
        sut.game.randomNumber = 1
        sut.game.userGuess = 1
        sut.playTurn()
        XCTAssertEqual(sut.game.didWin, true)
        XCTAssertNotNil(sut.resultsView)
    }
    
    func test_playTurn_RecognizesLoss() {
        sut.game.randomNumber = 1
        sut.game.userGuess = 8
        sut.game.strikes = 2
        sut.playTurn()
        XCTAssertEqual(sut.game.didWin, false)
        XCTAssertNotNil(sut.resultsView)
    }
    
    func test_playTurn_RecognizesPlayOn() {
        sut.game.randomNumber = 1
        sut.game.userGuess = 8
        sut.playTurn()
        XCTAssertEqual(sut.game.strikes, 1)
        XCTAssertNotNil(sut.strikesView)
    }
    
    func test_ShowGameStatus_CreatesBlackoutView() {
        sut.showGameStatus()
        XCTAssertNotNil(sut.blackoutView)
    }
    
    func test_ShowGameStatus_CreatesStrikesView() {
        sut.showGameStatus()
        XCTAssertNotNil(sut.strikesView)
    }
    
    func test_addStatusView_AddsStatusView() {
        sut.addStatusView()
        XCTAssertNotNil(sut.strikesView)
    }
    
    func test_strikesView_ShowsCorrectStrikeCount() {
        sut.game.randomNumber = 1
        sut.game.userGuess = 8
        sut.playTurn()
        let strikesLabelText = sut.strikesView.strikeCountLabel.text
        XCTAssertEqual(strikesLabelText, "Strikes: 1")
    }
    
    func test_strikesView_ShowsCorrectHint() {
        sut.game.randomNumber = 1
        sut.game.userGuess = 8
        sut.playTurn()
        let hintLabelText = sut.strikesView.hintLabel.text
        XCTAssertEqual(hintLabelText, "Guess lower!")
    }
    
    func test_activateResults_CreatesBlackoutView() {
        sut.activateResults()
        XCTAssertNotNil(sut.blackoutView)
    }
    
    func test_activateResults_CreatesResultsView() {
        sut.activateResults()
        XCTAssertNotNil(sut.resultsView)
    }
    
    func test_addResultsView_AddsResultsView() {
        sut.addResultsView()
        XCTAssertNotNil(sut.resultsView)
    }
    
    func test_resultsView_ShowCorrectResult() {
        sut.game.randomNumber = 1
        sut.game.userGuess = 1
        sut.playTurn()
        let resultsText = sut.resultsView.winLoseLabel.text
        XCTAssertEqual(resultsText, "You Win!")
    }
    
    func test_resultsView_ShowCorrectWinningNumber() {
        sut.game.randomNumber = 1
        sut.game.userGuess = 1
        sut.playTurn()
        let correctNumber = sut.resultsView.correctNumberLabel.text
        XCTAssertEqual(correctNumber, "1")
    }
    
    // test resultsView shows proper animation
    
    func test_playAgainPressed_RemovesBlackoutView() {
        sut.activateResults()
        sut.playAgainPressed(sender: sut.resultsView.playAgainButton)
        XCTAssertNil(sut.blackoutView)
    }
    
    func test_playAgainPressed_RemovesResultsView() {
        sut.activateResults()
        sut.playAgainPressed(sender: sut.resultsView.playAgainButton)
        XCTAssertNil(sut.resultsView)
    }
    
    func test_playAgainPressed_ResetsGame() {
        sut.activateResults()
        sut.playAgainPressed(sender: sut.resultsView.playAgainButton)
        XCTAssertNotNil(sut.game)
        XCTAssertEqual(sut.game.userGuess, 0)
        XCTAssertEqual(sut.game.strikes, 0)
        XCTAssertEqual(sut.game.didWin, false)
    }
    
    func test_guessAgainPressed_RemovesBlackoutView() {
        sut.showGameStatus()
        sut.guessAgainPressed(sender: sut.strikesView.guessAgainButton)
        XCTAssertNil(sut.blackoutView)
    }
    
    func test_guessAgainPressed_RemovesStrikesView() {
        sut.showGameStatus()
        sut.guessAgainPressed(sender: sut.strikesView.guessAgainButton)
        XCTAssertNil(sut.strikesView)
    }
    
}
