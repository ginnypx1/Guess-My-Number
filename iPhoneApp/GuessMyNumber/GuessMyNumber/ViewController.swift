//
//  ViewController.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 8/4/16.
//  Copyright © 2016 GhostBirdGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var StrikeCount: UILabel!
    @IBOutlet weak var hint: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var winLose: UILabel!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func guess(sender: AnyObject) {
    }

    @IBAction func playAgain(sender: AnyObject) {
    }
    
    
    
}

