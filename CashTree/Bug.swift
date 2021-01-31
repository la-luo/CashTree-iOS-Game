//
//  Bug.swift
//  CashTree
//
//  Created by La Luo on 1/29/21.
//

import SpriteKit

class Bug {
    
    var bugNode : SKSpriteNode!
    
    init(frame: CGRect) {
        bugNode = SKSpriteNode(texture: SKTexture(imageNamed: "bluebug_1"))
        bugNode.name = "BlueBug"
        bugNode.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(frame.maxX * 2))) - frame.maxX, y: frame.maxY - 100)
        bugNode.zPosition = 1
        bugNode.physicsBody = SKPhysicsBody(circleOfRadius: bugNode.size.width/2)
        bugNode.physicsBody?.categoryBitMask = PhysicsCategories.bluebugCategory
        bugNode.physicsBody?.contactTestBitMask = PhysicsCategories.playerCategory
        bugNode.physicsBody?.collisionBitMask = PhysicsCategories.none
        bugNode.physicsBody?.linearDamping = 0.1
    }
    
    func beginAnimation() {
        let bugAtlas = SKTextureAtlas(named: "bluebug")
        var bugFrames = [SKTexture]()
        for i in [1,2,3,4,5,4,3,2] {
            let bugTextName = "bluebug_\(i).png"
            bugFrames.append(bugAtlas.textureNamed(bugTextName))
        }
        print(bugFrames)
        let animate = SKAction.animate(withNormalTextures: bugFrames, timePerFrame: 1)
        let forever = SKAction.repeatForever(animate)
        print(forever)
        bugNode.run(forever)
        
    }
}
