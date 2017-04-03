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
//        exercise = Exercise(name:"4/7/8", rating:5, description:"A simple breathing exercise that acts like a sleeping pill. Inhale through your nose for four seconds, hold your breath for seven seconds, then exhale through your mouth for eight seconds.  Feel relaxed in no time.\nInhale: 4\nHold: 7\nExhale: 8", sequence:"I4,H7,O8",repetitions: 2)
        
        nameLabel.text = exercise!.name
        startBtn.setTitle("Start", for:.normal)
        resetBtn.isEnabled = false
        resetBtn.setTitle("Reset", for:.normal)
        
        running = false
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameBasedScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                GameBasedScene.exercise = self.exercise
                GameBasedScene.viewController = self
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
            
//            view.showsPhysics = true
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
            resetBtn.isEnabled = false
        } else if (GameBasedScene.ended! == true) {
            performSegue(withIdentifier: "resultsScreen", sender: nil)
        } else {
            GameBasedScene.running = false
            running = false
            startBtn.setTitle("Start", for:.normal)
            resetBtn.isEnabled = true
        }
    }
    
    @IBAction func didPressReset(_ sender: Any) {
        if (running! == false) {
            GameBasedScene.shouldReset = true
            resetBtn.isEnabled = false
        }
    }
    
    func gameDidEnd() {
        startBtn.setTitle("Results", for:.normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "resultsScreen") {
            let newView = segue.destination as! ResultsScreenViewController
            newView.exercise = self.exercise
            newView.score = GameBasedScene.score!
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
