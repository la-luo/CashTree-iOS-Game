//
//  GameScene.swift
//  CashTree
//
//  Created by La Luo on 1/23/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {
    
    private var tree : SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    var hero : SKSpriteNode!
    var scoreLabel: ScoreLabel!
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool { return true }
    
    override func didMove(to view: SKView) {

        setupPhysics()
        let pressed = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        pressed.delegate = self
        view.addGestureRecognizer(pressed)
        scoreLabel = ScoreLabel(frame: frame)
        addChild(scoreLabel)

        // Get tree node from scene and store it for use later
        self.tree = self.childNode(withName: "//tree") as? SKSpriteNode
        if let tree = self.tree {
            tree.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Recursive node search for 'hero'
        hero = (self.childNode(withName: "//player") as! SKSpriteNode)
        // allows the hero to animate when it's in the GameScene
        hero.isPaused  = false
        hero.physicsBody = SKPhysicsBody(rectangleOf: hero.size)
        hero.physicsBody?.collisionBitMask = PhysicsCategories.groundCategory
        hero.physicsBody?.categoryBitMask = PhysicsCategories.playerCategory
        hero.physicsBody?.friction = 0
        hero.physicsBody?.allowsRotation = false

    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("TODO: Add contact code")
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.dollarCategory | PhysicsCategories.playerCategory {
            print("find dollar contact")
            if let dollar = contact.bodyA.node?.name == "Dollar" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                scoreLabel.score! += 1
//                print(scoreLabel.score!)
                scoreLabel.updateScore()
                dollar.removeFromParent()
            }
        }
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {

        if sender.state == .began {
           print("LongPress BEGAN detected")
            hero.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 300))
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

//        let touchX = touches.first?.location(in: self).x ?? 0
//        let touchY = touches.first?.location(in: self).y ?? 0
        let heroX = hero.position.x

        for t in touches {
            let touchX = t.location(in: self).x
            let touchY = t.location(in: self).y
            if (touchX < -200 && touchX > -310) && (touchY < -200 && touchY > -280) {
                if heroX < -200 && heroX > -320 {
                    hero.physicsBody?.velocity.dx = 0
                    if let tree = self.tree {
                        tree.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
                    }
                    hero.run(SKAction.init(named: "hitTree")!, withKey: "hit")
                    spawnDollar()
                    let ranNum = Int.random(in: 1..<100)
                    spawnBug(ranNum: ranNum)
                }
            } else {
            if touchX < heroX {
                hero.physicsBody?.velocity.dx = -300
                if hero.xScale == 1.0 {
                    hero.xScale = -1.0
                }
            } else {
                hero.physicsBody?.velocity.dx = 300
                if hero.xScale == -1.0 {
                    hero.xScale = 1.0
                }
            }
        }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        if hero.position.x > 550 {
            hero.position.x = 550
        }
        if hero.position.x < -550 {
            hero.position.x = -550
        }
    }
    
    func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -8.0)
        physicsWorld.contactDelegate = self
    }
    
    func spawnDollar() {
        let dollar1 = Dollar(frame: frame)
        let dollar2 = Dollar(frame: frame)
        addChild(dollar1)
        addChild(dollar2)
    }
    
    func spawnBug(ranNum: Int) {
        if ranNum % 9 == 0 {
            let bug1 = Bug(frame: frame)
            addChild(bug1)
            bug1.beginAnimation()
        }
    }
}
