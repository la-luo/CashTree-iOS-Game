//
//  Bug.swift
//  CashTree
//
//  Created by La Luo on 1/29/21.
//

import SpriteKit

class Bug : SKSpriteNode {
    
    init(frame: CGRect) {
        let texture = SKTexture(imageNamed: "bluebug1")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.name = "BlueBug"
        self.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(frame.maxX * 2))) - frame.maxX, y: frame.maxY - 100)
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.categoryBitMask = PhysicsCategories.bluebugCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategories.playerCategory
        self.physicsBody?.collisionBitMask = PhysicsCategories.groundCategory
        self.physicsBody?.linearDamping = 0.1
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {

       let array = ["bluebug1", "bluebug2", "bluebug3", "bluebug4", "bluebug5"]
            var textures:[SKTexture] = []
            for i in 0 ..< array.count{
                let texture: SKTexture = SKTexture(imageNamed: array[i])
                textures.insert(texture, at:i)
            }
        let animate = SKAction.animate(with: textures, timePerFrame: 0.1)
    
        self.run(SKAction.repeatForever(animate))
        
    }
}
