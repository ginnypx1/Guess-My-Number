//
//  AnimationManager.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 6/25/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit

class AnimationManager {
    
    // MARK: - Animate Pop Up Views
    
    static func animateViewPopdown(popdownView: UIView, dropHeight: CGFloat) {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            popdownView.center.y += (800 + dropHeight)
        }, completion: nil)
    }
}
