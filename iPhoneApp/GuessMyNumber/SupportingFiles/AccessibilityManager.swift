//
//  AccessibilityManager.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 10/2/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit

struct AccessibilityManager {
    
    // MARK: - Apply Accessibility to PopupView Labels
    
    static func applyStrikeAccessibilityText(to label: UILabel, with strikes: Int) {
        label.accessibilityValue = String(strikes)
        label.accessibilityLabel = (strikes == 1) ? "You have \(strikes) strike" : "You have \(strikes) strikes"
    }
    
    static func applyHintAccessibilityText(to label: UILabel, for game: Game) {
        label.accessibilityLabel = (game.randomNumber < game.userGuess) ? "Guess lower!" : "Guess higher!"
    }
    
    static func applyResultsAccessibilityText(to label: UILabel, for game: Game) {
        label.accessibilityLabel = game.didWin ? "You Win!" : "You Lose!"
    }
    
    static func applyAnswerAccessibilityText(to label: UILabel, for game: Game) {
        label.accessibilityLabel = "The correct number was \(game.randomNumber)"
    }
    
    
    // MARK - Apply Dynamic Text to Button
    
    static func applyDynamicText(to button: UIButton) {
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}
