//
//  Alerts.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 6/25/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit

// MARK: - Alerts

class Alerts {
    
    static func displayAlert(from viewController: UIViewController) {
        // alert you must enter a number from 1-10
        let alertController = UIAlertController(title: nil, message: "Please enter a number 1-10", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default) { (action: UIAlertAction) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        // add actions to alert controller
        alertController.addAction(dismissAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}

