//
//  GameScene.swift
//  CashTree
//
//  Created by La Luo on 1/23/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var tree : SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    var hero : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        // Get tree node from scene and store it for use later
        self.tree = self.childNode(withName: "//tree") as? SKSpriteNode
        if let tree = self.tree {
            tree.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Recursive node search for 'hero'
        hero = (self.childNode(withName: "//player") as! SKSpriteNode)
        // allows the hero to animate when it's in the GameScene
        hero.isPaused  = false
        
        spawnDollar()
        
        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.03
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touchX = touches.first?.location(in: self).x ?? 0
        let touchY = touches.first?.location(in: self).y ?? 0
        let heroX = hero.position.x
//        let heroY = hero.position.y
        
        if (touchX < -200 && touchX > -310) && (touchY < -200 && touchY > -280) {
            if heroX < -200 && heroX > -320 {
                if let tree = self.tree {
                    tree.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
                }
            }
        } else {
            if touchX < heroX {
                hero.physicsBody?.applyImpulse(CGVector(dx:-20, dy:0))
                if hero.xScale == 1.0 {
                    hero.xScale = -1.0
                }
            } else {
                hero.physicsBody?.applyImpulse(CGVector(dx:20, dy:0))
                if hero.xScale == -1.0 {
                    hero.xScale = 1.0
                }
            }
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
//        let velocityX = hero.physicsBody?.velocity.dx ?? 0
//        
//        if velocityX > 10 {
//            hero.physicsBody?.velocity.dx = 10;
//        }
    }
    
    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2)
        physicsWorld.contactDelegate = self
    }
    
    func spawnDollar() {
        let dollar1 = Dollar(frame: frame)
        let dollar2 = Dollar(frame: frame)
        addChild(dollar1.dollarNode)
        addChild(dollar2.dollarNode)
    }
}
