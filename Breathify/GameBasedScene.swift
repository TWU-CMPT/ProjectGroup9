//
//  GameBasedScene.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-22.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameBasedScene: SKScene {
    
    static var viewController:GameBasedViewController?
    static var exercise:Exercise?
    static var running:Bool?
    static var ended:Bool?
    static var shouldReset:Bool?
    static var score:Int?
    
    private var pin:SKSpriteNode?
    private var pinCanMove:Bool?
    private var scoreLabel:SKLabelNode?
    private var sequence:[[Any]]?
    private var repetitions:Int?
    private var step:Int?
    private var lastTime:Double?
    private var lineAnchor:SKSpriteNode?
    private var dotAnchor:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.pin = self.childNode(withName: "playerPin") as? SKSpriteNode
        pin!.position.y = 0
        pin!.color = UIColor.black
        
        self.scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        scoreLabel!.text = "Score: 0"
        
        sequence = GameBasedScene.exercise?.sequence
        repetitions = GameBasedScene.exercise?.repetitions
        step = 1
        GameBasedScene.score = 0
        GameBasedScene.running = false
        GameBasedScene.shouldReset = false
        GameBasedScene.ended = false
        
        parseSequence(sequence:self.sequence!)
    }
    
    func reset() {
        lineAnchor!.removeAllChildren()
        dotAnchor!.removeAllChildren()
        
        pin!.position.y = 0
        step = 1
        GameBasedScene.score = 0
        GameBasedScene.running = false
        GameBasedScene.shouldReset = false
        GameBasedScene.ended = false
        
        parseSequence(sequence:self.sequence!)
    }
    
    func endGame() {
        GameBasedScene.ended = true
        GameBasedScene.viewController!.gameDidEnd()
        print("Game has ended.")
    }
    
    func touchDown(atPoint pos : CGPoint) {
        checkPress(pos:pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if (pinCanMove == true) {
            processMove(pos: pos)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        pinCanMove = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        if (GameBasedScene.shouldReset! == true) {
            GameBasedScene.shouldReset! = false
            reset()
            scoreLabel!.text = "Score: \(GameBasedScene.score!)"
        }
        
        if (GameBasedScene.running! == false || lastTime == nil) {
            lastTime = currentTime
        }
        
        // Game loop
        while (GameBasedScene.running! == true && (currentTime - lastTime!) >= (1.0 / 60.0)) {
            
            // Update score label
            scoreLabel!.text = "Score: \(GameBasedScene.score!)"
            
            // Moving elements
            lastTime! += 1.0 / 60.0
            lineAnchor!.position.x -= pin!.size.width / 60.0
            dotAnchor!.position.x -= pin!.size.width / 60.0
        
            // Score detection
            if (lineAnchor!.children[step!-1].contains(
                CGPoint(x:pin!.position.x + pin!.size.width - lineAnchor!.position.x,
                        y:pin!.position.y + pin!.size.height / 2))) {
                let instrNum = ((step! - 2) % (GameBasedScene.exercise!.sequence?.count)!)
                
                if (instrNum >= 0) {
                    let instrChar = String(GameBasedScene.exercise!.sequence?[instrNum][0] as! Character)
                    let hitRadius = pin!.size.height / 2
                    
                    let w = dotAnchor!.children[step!].position.x - dotAnchor!.children[step! - 1].position.x
                    let x = w - (dotAnchor!.children[step!].position.x - (-dotAnchor!.position.x) - pin!.size.width)
                    
                    switch(instrChar) {
                    case "H":
                        GameBasedScene.score! += 1
                        break
                    case "I":
                        let h = dotAnchor!.children[step!].position.y - dotAnchor!.children[step! - 1].position.y
                        let y = CGFloat(x) / CGFloat(w) * CGFloat(h)

                        if (pin!.position.y <= (y + hitRadius) && pin!.position.y >= (y - hitRadius)) {
                            GameBasedScene.score! += 1
                        }
                        break
                    case "O":
                        let h = dotAnchor!.children[step! - 1].position.y - dotAnchor!.children[step!].position.y
                        let y = CGFloat(h) - (CGFloat(x) / CGFloat(w) * CGFloat(h))

                        if (pin!.position.y <= (y + hitRadius) && pin!.position.y >= (y - hitRadius)) {
                            GameBasedScene.score! += 1
                        }
                        break
                    default:
                        break
                    }
                }
            }
        
            // Check step
            if (dotAnchor!.children[step!].position.x <= (-dotAnchor!.position.x + pin!.size.width)) {
                step! += 1
                
                if (step! >= dotAnchor!.children.count) {
                    GameBasedScene.running = false
                    endGame()
                }
            }
        }
    }
    
    func checkPress(pos:CGPoint) {
        if ((pin) != nil) {
            pinCanMove = true
        } else {
            pinCanMove = false
        }
    }
    
    func processMove(pos:CGPoint) {
        if (pos.y >= self.size.height / 2 - pin!.size.height / 2) {
            pin?.position.y = self.size.height / 2 - pin!.size.height
        } else if (pos.y <= pin!.size.height / 2) {
            pin?.position.y = 0
        } else {
            pin?.position.y = pos.y - pin!.size.height / 2
        }
    }
    
    func parseSequence(sequence:[[Any]]) {
        let dotInTexture = SKTexture.init(image: UIImage(named: "dot_in")!)
        let dotOutTexture = SKTexture.init(image: UIImage(named: "dot_out")!)
        let dotHoldTexture = SKTexture.init(image: UIImage(named: "dot_hold")!)
        let dotStartTexture = SKTexture.init(image: UIImage(named: "dot_start")!)
        let lineColor = SKColor.blue
        let dotColor = UIColor.white
        
        // Setup lines anchor
        lineAnchor = SKSpriteNode()
        lineAnchor!.anchorPoint = CGPoint(x:0.0, y:0.0)
        lineAnchor!.size = CGSize(width:0.0, height:0.0)
        self.addChild(lineAnchor!)
        
        // Setup dots anchor
        dotAnchor = SKSpriteNode()
        dotAnchor!.anchorPoint = CGPoint(x:0.0, y:0.0)
        dotAnchor!.size = CGSize(width:0.0, height:0.0)
        self.addChild(dotAnchor!)
        
        // Line drawing properties
        let unitWidth = pin!.size.width
        let unitHeight = pin!.size.height
        let lineRatio = CGFloat(0.2)
        let lineHeight = unitHeight * lineRatio
        let circleRadius = lineHeight * 2
        let height = self.size.height / 2 - pin!.size.height
        var offset = pin!.size.width
        let minHeight = pin!.size.height / 2
        let maxHeight = self.size.height / 2 - pin!.size.height / 2
        var currHeight = minHeight
        
        // 3 second lead in
        let leadLine = SKSpriteNode()
        leadLine.color = lineColor
        leadLine.anchorPoint = CGPoint(x:0.0, y:0.5)
        leadLine.position.x = offset
        leadLine.size.height = lineHeight
        leadLine.size.width = unitWidth * 3.0
        leadLine.position.y = currHeight
        leadLine.zPosition = -2
        lineAnchor!.addChild(leadLine)
        
        let leadDot = SKShapeNode(circleOfRadius: circleRadius)
        leadDot.strokeColor = dotColor
        leadDot.fillColor = dotColor
        leadDot.position.x = offset
        leadDot.zPosition = -1
        leadDot.isAntialiased = true
        leadDot.position.y = currHeight
        leadDot.fillTexture = dotStartTexture
        dotAnchor!.addChild(leadDot)
        
        offset += leadLine.size.width
        
        for _ in 1...repetitions! {
            for j in 0...sequence.count-1 {
                let inLine = SKSpriteNode()
                
                // Step line indicator
                inLine.color = lineColor
                inLine.anchorPoint = CGPoint(x:0.0, y:0.5)
                inLine.position.x = offset
                inLine.size.height = lineHeight
                let base = CGFloat(sequence[j][1] as! Int) * unitWidth
                inLine.size.width = sqrt(base * base + height * height)
                inLine.zPosition = -2
                
                // Start of line dot indicator
                let lineDot = SKShapeNode(circleOfRadius:circleRadius)
                lineDot.strokeColor = dotColor
                lineDot.fillColor = dotColor
                lineDot.position.x = offset
                lineDot.zPosition = -1
                lineDot.isAntialiased = true
                
                // Generating sequence lines
                // Setting dot texture
                switch(String(sequence[j][0] as! Character)) {
                case "I":
                    inLine.position.y = minHeight
                    inLine.zRotation = atan(height / base)
                    
                    lineDot.position.y = minHeight
                    lineDot.fillTexture = dotInTexture
                    
                    currHeight = maxHeight
                    break;
                case "O":
                    inLine.position.y = maxHeight
                    inLine.zRotation = -atan(height / base)
                    
                    lineDot.position.y = maxHeight
                    lineDot.fillTexture = dotOutTexture
                    
                    currHeight = minHeight
                    break;
                case "H":
                    inLine.position.y = currHeight
                    inLine.size.width = base
                    
                    lineDot.position.y = currHeight
                    lineDot.fillTexture = dotHoldTexture
                    break;
                default:
                    break;
                }
                
                offset += CGFloat(sequence[j][1] as! Int) * unitWidth
                
                lineAnchor!.addChild(inLine)
                dotAnchor!.addChild(lineDot)
            }
        }
        // End dot
        let lineDot = SKShapeNode(circleOfRadius:circleRadius)
        lineDot.strokeColor = dotColor
        lineDot.fillColor = dotColor
        lineDot.position.x = offset
        lineDot.position.y = currHeight
        lineDot.zPosition = -1
        lineDot.isAntialiased = true
        dotAnchor!.addChild(lineDot)
    }
    
}
