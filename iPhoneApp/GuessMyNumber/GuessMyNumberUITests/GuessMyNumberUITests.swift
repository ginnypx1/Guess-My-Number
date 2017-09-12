//
//  GuessMyNumberUITests.swift
//  GuessMyNumberUITests
//
//  Created by Ginny Pennekamp on 9/12/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import XCTest

class GuessMyNumberUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGuess() {
        // test GuessTextField exists
        let guessTextField = app.textFields["GuessTextField"]
        XCTAssert(guessTextField.exists)
        
        // test GuestButton exists
        let guessButton = app.buttons["GuessButton"]
        XCTAssert(guessButton.exists)
        
        // test incorrect guess displays alert
        app.textFields["GuessTextField"].tap()
        app.textFields["GuessTextField"].accessibilityElementIsFocused()
        app.textFields["GuessTextField"].typeText("a")
        app/*@START_MENU_TOKEN@*/.buttons["GuessButton"]/*[[".buttons[\"Guess Button\"]",".buttons[\"GuessButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts.buttons["Dismiss"].tap()
        
        // type a guess in the text field
        app.textFields["GuessTextField"].tap()
        app.textFields["GuessTextField"].accessibilityElementIsFocused()
        app/*@START_MENU_TOKEN@*/.textFields["GuessTextField"]/*[[".textFields[\"5\"]",".textFields[\"GuessTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("5")
        
        // tap the guess button
        app/*@START_MENU_TOKEN@*/.buttons["GuessButton"]/*[[".buttons[\"Guess Button\"]",".buttons[\"GuessButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        // TODO: test it sets the user guess
    }
    
}
