//
//  GuessMyNumberGameModelTests.swift
//  GuessMyNumberTests
//
//  Created by Ginny Pennekamp on 9/7/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import XCTest
@testable import GuessMyNumber

class GuessMyNumberGameModelTests: XCTestCase {
    
    var sut: Game!
    
    override func setUp() {
        super.setUp()
        // initiate game
        sut = Game()
    }
    
    override func tearDown() {
        // deinit game
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test properties exist
    
    func test_Game_HasRandomNumber() {
        let randomNumber = sut.randomNumber
        XCTAssertNotNil(randomNumber)
    }
    
    func test_Game_HasUserGuess() {
        let userGuess = sut.userGuess
        XCTAssertNotNil(userGuess)
    }
    
    func test_Game_HasStrikes() {
        let strikes = sut.strikes
        XCTAssertNotNil(strikes)
    }
    
    func test_Game_HasDidWin() {
        let didWin = sut.didWin
        XCTAssertNotNil(didWin)
    }
    
    // MARK: - Test initial game state
    
    func test_Game_HasRandomNumber_BetweenOneAndTen() {
        let randomNumber = sut.randomNumber
        XCTAssertGreaterThan(randomNumber, 0)
        XCTAssertLessThanOrEqual(randomNumber, 10)
    }
    
    func test_Game_InitializesUserGuess_AsZero() {
        let userGuess = sut.userGuess
        XCTAssertEqual(userGuess, 0)
    }
    
    func test_Game_InitializesStrikes_AsZero() {
        let strikes = sut.strikes
        XCTAssertEqual(strikes, 0)
    }
    
    func test_Game_InitializesDidWin_AsFalse() {
        let didWin = sut.didWin
        XCTAssertEqual(didWin, false)
    }
    
}
