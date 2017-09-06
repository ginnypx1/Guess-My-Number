//
//  ResultsView.swift
//  GuessMyNumber
//
//  Created by Ginny Pennekamp on 6/25/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit
import SceneKit

@IBDesignable class ResultsView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var sceneKitView: SCNView!
    @IBOutlet weak var winLoseLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var correctNumberLabel: UILabel!
    
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
        let nib = UINib(nibName: "ResultsView", bundle: bundle)
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
    
    // MARK: - Create Win View
    
    static func create(in containerView: UIView, with game: Game) -> UIView {
        let viewWidth = containerView.frame.size.width >= containerView.frame.height ? (containerView.frame.size.height * 0.8) : (containerView.frame.size.width * 0.8)
        let viewHeight = containerView.frame.size.width >= containerView.frame.height ? (containerView.frame.size.height * 0.8) : (containerView.frame.size.height * 0.8)
        
        let resultsView = ResultsView(frame: CGRect(x: (containerView.frame.size.width-viewWidth)/2 , y: -800, width: viewWidth, height: viewHeight))
        
        // State win or lose
        resultsView.winLoseLabel.text = game.didWin ? "You Win!" : "You Lose!"
        resultsView.correctNumberLabel.text = "\(game.randomNumber)"
        
        // play graphics
        let myScene = SCNScene()
        let particleNode = SCNNode()
        let particleSystem = game.didWin ? SCNParticleSystem(named: "Confetti", inDirectory: "") : SCNParticleSystem(named: "Rainstorm", inDirectory: "")
        particleNode.addParticleSystem(particleSystem!)
        myScene.rootNode.addChildNode(particleNode)
        resultsView.sceneKitView.scene = myScene
        
        return resultsView
    }
    
}

