//
//  AnimationManager.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 6/25/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit

class AnimationManager {
    
    // MARK: - Fade in directions
    
    static func fadeInDirections(for labels: [UILabel]) {
        let duration: TimeInterval = 2.5
        var delay: TimeInterval = 0
        for label in labels {
            UIView.animate(withDuration: duration, delay: delay, animations: {
                label.alpha = 1
            })
            delay += 0.5
        }
    }
    
    // MARK: - Drop down view
    
    static func animateViewPopdown(popdownView: UIView, dropHeight: CGFloat) {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            popdownView.center.y += (800 + dropHeight)
        }, completion: nil)
    }
    
    // MARK: - Remove view
    
    static func removePopdown(_ view: UIView, blackoutView: UIView) {
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            view.center.y -= 900
        }, completion: { finished in
            // remove the superviews and start a new game
            view.removeFromSuperview()
            blackoutView.removeFromSuperview()
        })
    }
    
    // MARK: - Spin correct answer
    static func spinAnswer(in label: UILabel) {
        let anim = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            label.transform = label.transform.rotated(by: CGFloat(Double.pi))
            label.transform = label.transform.rotated(by: CGFloat(Double.pi))
            label.transform = label.transform.rotated(by: CGFloat(Double.pi))
            label.transform = label.transform.rotated(by: CGFloat(Double.pi))
            label.transform = label.transform.rotated(by: CGFloat(Double.pi))
            label.transform = label.transform.rotated(by: CGFloat(Double.pi))
        }
        anim.addAnimations {
            let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
            label.transform = scale
        }
        anim.startAnimation()
    }
}
