//
//  ScoreLabel.swift
//  CashTree
//
//  Created by La Luo on 2/21/21.
//

import SpriteKit

class ScoreLabel: SKLabelNode {
    var score : Int?
    
    init(frame: CGRect) {
        super.init()
        self.score = 0
        self.text = "$ 0"
        self.position = CGPoint(x: CGFloat(500), y: CGFloat(300))
        self.zPosition = 2
        self.fontColor = UIColor.white
        self.fontSize = 42.0
        self.fontName = "AvenirNext-Bold"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateScore() {
        self.text = "$ \(self.score ?? 0)"
    }
}
