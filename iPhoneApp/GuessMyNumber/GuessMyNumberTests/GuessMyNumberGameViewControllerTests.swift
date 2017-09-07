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
    
    // test guess entering text in text field sets user guess
    // test guess entering wrong info sets off alert
    // test guess resets text field text to ""
    // test guess resets placeholder text to 5
    
    // test play turn recognizes win
    // test play turn recognizes loss
    // test play turn recognizes play on
    
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
    
    // test strikesView shows proper strikes
    // test strikesView shows higher or lower
    
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
    
    // test resultsView shows proper result
    // test resultsView shows proper number
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
