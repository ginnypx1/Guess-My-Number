//
//  StrikesView.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 6/25/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//
import UIKit

@IBDesignable class StrikesView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var strikeCountLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var guessAgainButton: UIButton!
    
    // MARK: - Properties
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    var view: UIView?
    
    // MARK: - Load Popdown View
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "StrikesView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        view?.prepareForInterfaceBuilder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
    }
    
    static func create(in containerView: UIView, with game: Game) -> UIView {
        let viewWidth = containerView.frame.size.width >= containerView.frame.height ? (containerView.frame.size.height * 0.9) : (containerView.frame.size.width * 0.8)
        let viewHeight = containerView.frame.size.width >= containerView.frame.height ? (containerView.frame.size.height * 0.7) : (containerView.frame.size.height * 0.5)
        
        let strikesView = StrikesView(frame: CGRect(x: (containerView.frame.size.width-viewWidth)/2 , y: -800, width: viewWidth, height: viewHeight))
        
        strikesView.strikeCountLabel.text = "Strikes: \(game.strikes)"
        strikesView.hintLabel.text = (game.randomNumber < game.userGuess) ? "Guess lower!" : "Guess higher!"
        
        // Add accessibility to view
        AccessibilityManager.applyDynamicText(to: strikesView.guessAgainButton)
        AccessibilityManager.applyStrikeAccessibilityText(to: strikesView.strikeCountLabel, with: game.strikes)
        AccessibilityManager.applyHintAccessibilityText(to: strikesView.hintLabel, for: game)
        
        return strikesView
    }
    
}
