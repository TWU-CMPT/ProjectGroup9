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
    
    static var exercise:Exercise?
    static var running:Bool?
    static var shouldReset:Bool?
    static var score:Int?
    
    private var pin:SKSpriteNode?
    private var pinCanMove:Bool?
    private var sequence:[[Any]]?
    private var repetitions:Int?
    private var step:Int?
    private var lastTime:Double?
    private var lineAnchor:SKSpriteNode?
    private var dotAnchor:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.pin = self.childNode(withName: "playerPin") as? SKSpriteNode
        pin!.position.y = 0
        
        sequence = GameBasedScene.exercise?.sequence
        repetitions = GameBasedScene.exercise?.repetitions
        step = 0
        GameBasedScene.score = 0
        GameBasedScene.running = false
        GameBasedScene.shouldReset = false
        
        parseSequence(sequence:self.sequence!)
    }
    
    func reset() {
        lineAnchor!.removeAllChildren()
        dotAnchor!.removeAllChildren()
        
        pin!.position.y = 0
        step = 0
        GameBasedScene.score = 0
        GameBasedScene.running = false
        GameBasedScene.shouldReset = false
        
        parseSequence(sequence:self.sequence!)
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
        }
        
        if (GameBasedScene.running! == false || lastTime == nil) {
            lastTime = currentTime
        }
        // check for next step
        while (GameBasedScene.running! == true && (currentTime - lastTime!) >= (1.0 / 60.0)) {
            print("score: \(GameBasedScene.score)")
            print("\(dotAnchor!.children[step!+1].position.x)")
            if (step! < dotAnchor!.children.count) {
                lastTime! += 1.0 / 60.0
                lineAnchor!.position.x -= pin!.size.width / 60.0
                dotAnchor!.position.x -= pin!.size.width / 60.0
                
                if (lineAnchor!.children[step!].contains(
                    CGPoint(x:pin!.position.x + pin!.size.width - lineAnchor!.position.x,
                            y:pin!.position.y + pin!.size.height / 2))) {
                    GameBasedScene.score! += 1
                }
                
                if (dotAnchor!.children[step!+1].position.x + dotAnchor!.position.x <= pin!.position.x + pin!.size.width) {
                    step! += 1
                }
            } else {
                GameBasedScene.running = false
            }
            
        }
    }
    
    func checkPress(pos:CGPoint) {
        if ((pin) != nil && pin!.contains(pos)) {
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
        var offset = pin!.size.width / 2 * 3
        let minHeight = pin!.size.height / 2
        let maxHeight = self.size.height / 2 - pin!.size.height / 2
        var currHeight = minHeight
        
        // 3 second lead in
        let leadLine = SKSpriteNode()
        leadLine.color = .black
        leadLine.anchorPoint = CGPoint(x:0.0, y:0.5)
        leadLine.position.x = offset
        leadLine.size.height = lineHeight
        leadLine.size.width = unitWidth * 3.0
        leadLine.position.y = currHeight
        leadLine.zPosition = -2
        lineAnchor!.addChild(leadLine)
        
        let leadDot = SKShapeNode(circleOfRadius: circleRadius)
        leadDot.strokeColor = .black
        leadDot.fillColor = .black
        leadDot.position.x = offset
        leadDot.zPosition = -1
        leadDot.isAntialiased = true
        leadDot.position.y = currHeight
        dotAnchor!.addChild(leadDot)
        
        offset += leadLine.size.width
        
        for _ in 1...repetitions! {
            for j in 0...sequence.count-1 {
                let inLine = SKSpriteNode()
                
                // Step line indicator
                inLine.color = .black
                inLine.anchorPoint = CGPoint(x:0.0, y:0.5)
                inLine.position.x = offset
                inLine.size.height = lineHeight
                let base = CGFloat(sequence[j][1] as! Int) * unitWidth
                inLine.size.width = sqrt(base * base + height * height)
                inLine.zPosition = -2
                
                // Start of line dot indicator
                let lineDot = SKShapeNode(circleOfRadius:circleRadius)
                lineDot.strokeColor = .black
                lineDot.fillColor = .black
                lineDot.position.x = offset
                lineDot.zPosition = -1
                lineDot.isAntialiased = true
                
                // Generating sequence lines
                switch(String(sequence[j][0] as! Character)) {
                case "I":
                    inLine.position.y = minHeight
                    inLine.zRotation = atan(height / base)
                    
                    lineDot.position.y = minHeight
                    
                    currHeight = maxHeight
                    break;
                case "O":
                    inLine.position.y = maxHeight
                    inLine.zRotation = -atan(height / base)
                    lineDot.position.y = maxHeight
                    
                    currHeight = minHeight
                    break;
                case "H":
                    inLine.position.y = currHeight
                    inLine.size.width = base
                    
                    lineDot.position.y = currHeight
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
        lineDot.strokeColor = .black
        lineDot.fillColor = .black
        lineDot.position.x = offset
        lineDot.position.y = currHeight
        lineDot.zPosition = -1
        lineDot.isAntialiased = true
        dotAnchor!.addChild(lineDot)
    }
    
}
