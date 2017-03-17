//
//  TimeBasedViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-06.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class TimerBasedViewController: UIViewController {
    
    var time:Double = 0
    var temp:Double = 0
    var timer = Timer()
    var timer2 = Timer()
    var breathIn:Double = 4.0
    var breathHold:Double = 7.0
    var breathOut:Double = 8.0
    var breathSwitch = 1
    var breathPattern = 1
    
    var exercise:Exercise = Exercise()
    
    @IBOutlet weak var ProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var TimerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Example of how sequence is stored in Exercise
        print("\(exercise.name)")
        if ((exercise.sequence) != nil) {
            for step in exercise.sequence! {
                print("\(step)")
            }
        }
    }
    
    @IBAction func Holddown(_ sender: UIButton) {
        runBreathIn()
    }
    
    @IBAction func Release(_ sender: UIButton) {
        runBreathOut()
    }
    
    func runBreathOut(){
        
        timer.invalidate()
        
        if(time != 0){
            TimerLabel.text = String("Please Try Again.")
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.ProgressBarView.value = 0
            }, completion: nil)
            
        }
        else{
            time = breathOut
            temp = breathOut + 1
        
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.BreathOutControl), userInfo: nil, repeats: true)
        
            UIView.animate(withDuration: temp, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.ProgressBarView.value = 0
            }, completion: nil)
            
            breathPattern -= 1
        }

        
    }
    
    func runBreathIn(){
        
        
        time = breathIn
        breathSwitch = 1
        TimerLabel.text = String("Breath In")
        print(breathPattern)
        

        UIView.animate(withDuration: 4.0, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.ProgressBarView.value = 100
        }, completion: ({finished in
            if(finished){
                self.TimerLabel.text = String("Hold")
                self.time = self.breathHold
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.BreathHoldControl), userInfo: nil, repeats: true)
            }
        }))

        
    }
    
    func BreathOutControl(){
        if(time > 0){
            TimerLabel.text = String(Int(time))
            time -= 1
        }
        else{
            TimerLabel.text = String("Next Breath")
            timer2.invalidate()
            
        }
    }
    
    func BreathHoldControl(){
        if(time > 0){
            TimerLabel.text = String(Int(time))
            time -= 1
        }
        else{
            TimerLabel.text = String("Release to Breath Out")
            timer.invalidate()
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
