//
//  Dollar.swift
//  CashTree
//
//  Created by La Luo on 1/24/21.
//

import SpriteKit

class Dollar : SKSpriteNode {
    
    init(frame: CGRect) {

        let texture = SKTexture(imageNamed: "dollar")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.name = "Dollar"
        self.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(frame.maxX * 2))) - frame.maxX, y: frame.maxY - 100)
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/3)
        self.physicsBody?.linearDamping = 3
        self.physicsBody?.categoryBitMask = PhysicsCategories.dollarCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategories.playerCategory
        self.physicsBody?.collisionBitMask = PhysicsCategories.none
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
