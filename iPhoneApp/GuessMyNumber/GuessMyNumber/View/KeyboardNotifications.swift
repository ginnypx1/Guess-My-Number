//
//  KeyboardNotifications.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 4/9/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    // MARK: - Keyboard Notifications
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        // gets the size of the user's keyboard
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // shifts the view up the height of the keyboard
        if guessTextField.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // shifts the view down to the bottom when keyboard closes
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        // subscribes to keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        // unsubscribes to keyboard notifications
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Dismiss the keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guessTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        guessTextField.endEditing(true)
        return false
    }
    
    // MARK: - Add Tap Gesture Recognizer to dismiss view and end editing
    
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func didTapView(){
        guessTextField.endEditing(true)
    }
}
