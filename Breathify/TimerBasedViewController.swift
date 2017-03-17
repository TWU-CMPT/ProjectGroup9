//
//  TimeBasedViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-06.
//  Copyright © 2017 Group Nein. All rights reserved.

import UIKit
import MBCircularProgressBar

class TimerBasedViewController: UIViewController {
    
    let inText = "Breath In"
    let hoText = "Hold"
    let outText = "Breath Out"
    let errDet = "Please Try Again"
    
    @IBOutlet weak var patternLabel: UILabel!
    
    //Two timers

    var time:Double = 0
    var temp:Double = 0
    var timer = Timer()
    var timer2 = Timer()
    
    //for the sequence parsing, need to code the information into this four variables
    
    var breathIn:Double = 4.0
    var breathHold:Double = 7.0
    var breathOut:Double = 8.0
    var breathHold2:Double = 0
    var breathPattern = 4
    
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
            //error checking
            TimerLabel.text = errDet
            patternLabel.text = String(String(breathPattern) + " breath left")
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.ProgressBarView.value = 0
            }, completion: nil)
            
        }
        
        else if(breathPattern == 0){
            //End checking
            patternLabel.text = String(String(breathPattern) + " breath left")
            print("Exercise Ends here")
            
            //Adding the method for result screen later...
        }
        
        else{
            //Breath Out Process
            TimerLabel.text = outText
            time = breathOut
            temp = breathOut + 1
        
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.BreathOutControl), userInfo: nil, repeats: true)
        
            UIView.animate(withDuration: temp, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.ProgressBarView.value = 0
            }, completion:  ({finished in
                if(finished){
                    
                    if(self.breathHold2 != 0){
                        //waiting method(possible to add later)
                    }

                }
            }))
            
            breathPattern -= 1
        }

        
    }
    
    func runBreathIn(){
        
        if(breathPattern != 0){
        //breath in Process
        
            time = breathIn
            TimerLabel.text = inText
            patternLabel.text = String(String(breathPattern - 1) + " breath left")
            print(breathPattern)
        

            UIView.animate(withDuration: 4.0, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.ProgressBarView.value = 100
            }, completion: ({finished in
                if(finished){
                    //with or without hold

                    if(self.breathHold != 0){
                        self.TimerLabel.text = self.hoText
                        self.time = self.breathHold
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.BreathHoldControl), userInfo: nil, repeats: true)
                    }
                    else{
                        self.TimerLabel.text = String("Release to Breath Out")
                        self.time = 0
                    }
                }
            }))
        }
        else{
            //do nothing for now
        }

        
    }

    
    func BreathOutControl(){
        if(time > 0){
            TimerLabel.text = String(Int(time))
            time -= 1
        }
        else{
            if(breathPattern == 0){
                //END CHECKING
                //IT IS POSSIBLE TO CHANGE THE BUTTON VIEW TO "FINISH",THEN PRESS FOR THE RESULT SCREEN
                
                patternLabel.text = String(String(breathPattern) + " exercise left")
                TimerLabel.text = String("Ends Here")
                timer2.invalidate()
            }
            else{
                TimerLabel.text = String("Next Breath")
                timer2.invalidate()
            }
            
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
