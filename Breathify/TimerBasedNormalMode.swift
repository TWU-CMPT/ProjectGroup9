//
//  TimerBasedNormalMode.swift
//  Breathify
//
//  Created by Ziyou Xu on 17/3/21.
//  Copyright © 2017年 Group Nein. All rights reserved.
//

import UIKit
import MBCircularProgressBar


class TimerBasedNormalMode: UIViewController {

    var exercise:Exercise = Exercise()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var stateButton: UIButton!
    
    @IBOutlet weak var progressBarView: MBCircularProgressBarView!
    
    
    enum State {
        case stopped
        case running
        case paused
        case breatheIn
        case breatheOut
        case holdBreath
    }
    
    let inText = "Breathe In"
    let outText = "Breathe Out"
    let holdText = "Hold Your Breath"
    
    var state = State.stopped
    
    var barValue:CGFloat = 0
    var step:Int = 0
    var numSteps:Int = 0
    var nextStep:[Any] = []
    var exercisePeriod:Int = 2
    
    var stepTime:Double = 0
    var timer = Timer()
    var startTimer = Timer()
    var startTime:Int = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        numSteps = (exercise.sequence?.count)!
        nextStep = (exercise.sequence?[step])!
        
        nameLabel.text = String(exercisePeriod) + String(" Breath left")
        exercisePeriod = (exercise.repetitions)!
        
        progressBarView.value = 0
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressState(_ sender: Any) {
        switch (state) {
        case .stopped:
            startExercise()
            state = .running
            break
        case .running:
            pauseExercise()
            state = .stopped
            break
        case .paused:
            resetExercise()
            state = .stopped
            break
        default:
            break
        }
        
        
    }
    
    
    func tick() {
        stepTime -= 1
        
        timerLabel.text = String(Int(stepTime))
        
        if (stepTime <= 0) {
            timer.invalidate()
            exerciseStep()
        }
    }
    
    func exerciseStep() {
        if (exercisePeriod == 0) {
            // END EXERCISE
            timerLabel.text = String("END.")
            nameLabel.text = String(" ")
            state = .stopped
            print("Exercise Ended")
            startTime = 3
            return
        }
        else if(step == numSteps - 1){
            exercisePeriod -= 1
        }
        else if(step >= numSteps){
            step = 0
        }
        
        nextStep = (exercise.sequence?[step])!
        
        nameLabel.text = String(exercisePeriod) + String(" Breath left")
        
        
        let instruction = String(nextStep[0] as! Character)
        stepTime = Double(nextStep[1] as! Int)
        
        switch (instruction) {
        case "I":
            barValue = 100
            timerLabel.text = inText
            break
        case "O":
            barValue = 0
            timerLabel.text = outText
            
            break
        case "H":
            timerLabel.text = holdText
            break
        default:
            break;
        }
        
        step += 1
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
        
        if (instruction != "H") {
            UIView.animate(withDuration: stepTime, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.progressBarView.value = self.barValue
            }, completion: nil)
        }
    }
    
    //Start the exercise
    func startExercise() {
        timerLabel.text = String(startTime)
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.tickS),userInfo: nil, repeats: true)
        stateButton.setTitle("STOP", for: .normal)
        
    }
    
    //Stop and Reset the exeercise
    func pauseExercise() {
        timer.invalidate()
        startTimer.invalidate()
        self.progressBarView.value = 0
        startTime = 3
        nameLabel.text = String(exercisePeriod) + String(" Breath left")
        timerLabel.text = String("Breathify")
        step = 0
        stateButton.setTitle("START", for: .normal)
    }
    
    func resetExercise() {
        
    }
    
    func tickS(){
        
        if(startTime < 1){
            
            step = 0
            exercisePeriod = (exercise.repetitions)!
            startTimer.invalidate()
            exerciseStep()
        }
        else if(startTime == 1){
            timerLabel.text = String("Start!")
            startTime -= 1
        }
        else{
            startTime -= 1
            timerLabel.text = String(startTime)
        }
        
    }
}
