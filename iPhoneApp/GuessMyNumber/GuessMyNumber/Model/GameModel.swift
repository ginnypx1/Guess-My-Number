//
//  GameModel.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 6/25/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import Foundation

// MARK: - Game Model

class Game {
    
    // MARK: - Properties
    
    var randomNumber: Int = 0
    
    var userGuess: Int = 0
    var strikes: Int = 0
    var didWin: Bool = false
    
    // MARK: - Init
    
    init() {
        self.randomNumber = Int(arc4random_uniform(10)) + 1
    }
    
}
