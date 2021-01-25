//
//  Dollar.swift
//  CashTree
//
//  Created by La Luo on 1/24/21.
//

import SpriteKit

class Dollar {
    
    var dollarNode : SKSpriteNode!
    
    init(frame: CGRect) {
        dollarNode = SKSpriteNode(texture: SKTexture(imageNamed: "dollar"))
        dollarNode.name = "Dollar"
        dollarNode.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(frame.maxX * 2))) - frame.maxX, y: frame.maxY - 100)
        dollarNode.zPosition = 3
        dollarNode.physicsBody = SKPhysicsBody(circleOfRadius: dollarNode.size.width/2)
    }
    
}
