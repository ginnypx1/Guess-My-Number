//
//  BlackoutView.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 9/6/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit

struct BlackoutView {
    
    // MARK: - Blackout View
    
    static func create(in view: UIView) -> UIView {
        let blackoutView = UIView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
        blackoutView.backgroundColor = UIColor.gray
        blackoutView.alpha = 0.5
        return blackoutView
    }
    
    
}
