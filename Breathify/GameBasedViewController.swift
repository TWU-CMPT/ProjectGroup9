//
//  GameBasedViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-22.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameBasedViewController: UIViewController {
    
    var exercise:Exercise?
    var running:Bool?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nameLabel.text = exercise!.name
        startBtn.setTitle("Start", for:.normal)
        
        running = false
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameBasedScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                GameBasedScene.exercise = self.exercise
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            view.showsPhysics = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBAction func didPressStart(_ sender: Any) {
        if (running! == false) {
            GameBasedScene.running = true
            running = true
            startBtn.setTitle("Stop", for:.normal)
            resetBtn.isHidden = true
        } else {
            GameBasedScene.running = false
            running = false
            startBtn.setTitle("Start", for:.normal)
            resetBtn.isHidden = false
        }
    }
    
    @IBAction func didPressReset(_ sender: Any) {
        if (running! == false) {
            GameBasedScene.shouldReset = true
            resetBtn.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
