//
//  GameScene.swift
//  Breakout
//
//  Created by Student on 3/15/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKShapeNode()
    var paddle = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        //This stuff happens once (When the app opens)
        createBackground()
        resetGame()
    }
    
    func resetGame() {
        // this stuff happens before each game starts
        makeBall()
        makePaddle()
    }
    
    func createBackground() {
        let stars = SKTexture(imageNamed: "Stars")
        for i in 0...1 {
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x: 0, y: starsBackground.size.height * CGFloat(i))
            addChild(starsBackground)
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            starsBackground.run(moveForever)
        }
}
    func makeBall() {
        ball.removeFromParent() //remove the ball (if it exists)
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .yellow
        ball.name = "ball"
        
        // physics shape matches ball image
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        // ignores all forces and impulses
        ball.physicsBody?.isDynamic = false
        // use precise collision detection
        ball.physicsBody?.usesPreciseCollisionDetection = true
        // no loss of energy from friction
        ball.physicsBody?.friction = 0
        // gravity is not a factor
        ball.physicsBody?.affectedByGravity = false
        // bounces fully off of other objects
        ball.physicsBody?.restitution = 1
        // does not slow down over time
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        
        addChild(ball)  // add ball object to the view
    }

func makePaddle() {
    paddle.removeFromParent()   // remove the paddle if it exists
    paddle = SKSpriteNode(color: .white, size: CGSize(width: frame.width/4, height: 20))
    paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
    paddle.name = "paddle"
    paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
    paddle.physicsBody?.isDynamic = false
    addChild(paddle)
}

}


