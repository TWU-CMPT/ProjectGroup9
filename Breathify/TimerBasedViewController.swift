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
    let hoText = "Hold Your Breath"
    let outText = "Breath Out"
    let errDet = "Press and Hold to Breath In"
    
    @IBOutlet weak var patternLabel: UILabel!
    
    //Two timers

    var time:Double = 0
    var temp:Double = 0
    var timer = Timer()
    var timer2 = Timer()
    var timer3 = Timer()
    
    //for the sequence parsing, need to code the information into this four variables
    

    var exercise:Exercise = Exercise()
    var breathPattern:Int = 0
    var breathIn:Double = 0.0
    var breathHold:Double = 0.0
    var breathOut:Double = 0.0
    var breathHold2:Double = 0
    var nextStep:[Any] = []
    var step:Int = 0
    var isHold:Int = 0
    
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
        
        breathPattern = (exercise.repetitions)!
        patternLabel.text = String(String(breathPattern) + " Breaths left")
        ProgressBarView.value = 0
        self.title = exercise.name
    }
    
    @IBAction func Holddown(_ sender: UIButton) {
        runBreathIn()
    }
    
    @IBAction func Release(_ sender: UIButton) {
        runBreathOut()
    }
    
    func runBreathOut(){
        
        timer.invalidate()
        
        if((time != 1) || (isHold == 0)){
            //error checking
            timer3.invalidate()
            TimerLabel.text = errDet
            patternLabel.text = String(String(breathPattern) + " Breaths left")
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.ProgressBarView.value = 0
            }, completion: nil)
            step = 0
            
        }
        
        else if(breathPattern == 0){
            //End checking
            patternLabel.text = String(String(breathPattern) + " Breaths left")
            print("Exercise Ends here")
            step  = 0
            //Adding the method for result screen later...
        }
        
        else{
            step += 1
            nextStep = (exercise.sequence?[step])!
            let breathOut = Double(nextStep[1] as! Int)
            //Breath Out Process
            TimerLabel.text = outText
            time = breathOut
            temp = breathOut
        
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.BreathOutControl), userInfo: nil, repeats: true)
        
            UIView.animate(withDuration: temp, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.ProgressBarView.value = 0
            }, completion:  ({finished in
                if(finished){
<<<<<<< HEAD
                    self.patternLabel.text = String(String(self.breathPattern) + " Breath left")
                    self.isHold = 0
=======
                    self.patternLabel.text = String(String(self.breathPattern) + " Breaths left")
>>>>>>> origin/timer-based-combined
                    self.step = 0
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
            
            nextStep = (exercise.sequence?[step])!
            let breathIn = Double(nextStep[1] as! Int)
            
            time = breathIn
            TimerLabel.text = inText
            if (breathPattern == 1) {
                patternLabel.text = String(String(breathPattern) + " Breath left")
            }
            else {
                patternLabel.text = String(String(breathPattern) + " Breaths left")
            }
            
            print(breathPattern)
            
            timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.BreathInControl), userInfo: nil, repeats: true)
            
            UIView.animate(withDuration: breathIn, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.ProgressBarView.value = 100
            }, completion: ({finished in
                if(finished){
                    //with or without hold
                    self.step += 1
                    self.nextStep = (self.exercise.sequence?[self.step])!
                    self.breathHold = Double(self.nextStep[1] as! Int)
                    
                    self.isHold = 1
                    
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
    
    func BreathInControl(){
        if(time > 1){
            time -= 1
            TimerLabel.text = String(Int(time))
        }
        else{
            timer3.invalidate()
        }
    
    }

    
    func BreathOutControl(){
        if(time > 1){
            time -= 1
            TimerLabel.text = String(Int(time))
            
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
        if(time > 1){
            time -= 1
            TimerLabel.text = String(Int(time))
            
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
