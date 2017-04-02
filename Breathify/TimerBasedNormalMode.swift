//
//  TimerBasedNormalMode.swift
//  Breathify
//
//  Created by Ziyou Xu on 17/3/21.
//  Copyright © 2017年 Group Nein. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import AVFoundation

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
    var exercisePeriod:Int = 0
    
    var stepTime:Double = 0
    var timer = Timer()
    var startTimer = Timer()
    var startTime:Int = 3
    
    var audioTimer0 = AVAudioPlayer()
    var audioTimer1 = AVAudioPlayer()
    var audioTimer2 = AVAudioPlayer()
    var audioTimer3 = AVAudioPlayer()
    var audioTimer4 = AVAudioPlayer()
    var audioTimer5 = AVAudioPlayer()
    var audioTimer6 = AVAudioPlayer()
    var audioTimer7 = AVAudioPlayer()
    var audioTimer8 = AVAudioPlayer()
    var audioTimerIn = AVAudioPlayer()
    var audioTimerHold = AVAudioPlayer()
    var audioTimerOut = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        numSteps = (exercise.sequence?.count)!
        nextStep = (exercise.sequence?[step])!
        
        nameLabel.text = String(exercisePeriod) + String(" Breath left")
        exercisePeriod = (exercise.repetitions)!
        
        progressBarView.value = 0
        
        do{
            audioTimer0 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "zero", ofType: "mp3")!))
            audioTimer0.prepareToPlay()
            audioTimer1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "one", ofType: "mp3")!))
            audioTimer1.prepareToPlay()
            audioTimer2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "two", ofType: "mp3")!))
            audioTimer2.prepareToPlay()
            audioTimer3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "three", ofType: "mp3")!))
            audioTimer3.prepareToPlay()
            audioTimer4 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "four", ofType: "mp3")!))
            audioTimer4.prepareToPlay()
            audioTimer5 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "five", ofType: "mp3")!))
            audioTimer5.prepareToPlay()
            audioTimer6 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "six", ofType: "mp3")!))
            audioTimer6.prepareToPlay()
            audioTimer7 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "seven", ofType: "mp3")!))
            audioTimer7.prepareToPlay()
            audioTimer8 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "eight", ofType: "mp3")!))
            audioTimer8.prepareToPlay()
            audioTimerIn = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "breath", ofType: "mp3")!))
            audioTimerIn.prepareToPlay()
            audioTimerHold = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "hold", ofType: "mp3")!))
            audioTimerHold.prepareToPlay()
            audioTimerOut = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "out", ofType: "mp3")!))
            audioTimerOut.prepareToPlay()
        }
        catch{
            print(error)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "StopTimerNotification"), object: nil)
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
        if(stepTime != 0){
            playsound(stepPlay: stepTime)
        }
        if (stepTime <= 0) {
            timer.invalidate()
            exerciseStep()
        }
    }
    
    func exerciseStep() {
        if (exercisePeriod == 0) {
            // END EXERCISE
            timerLabel.text = String("Breathify")
            nameLabel.text = String("end")
            stateButton.setTitle("RESTART", for: .normal)
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
            audioTimerIn.play()
            break
        case "O":
            barValue = 0
            timerLabel.text = outText
            audioTimerOut.play()
            break
        case "H":
            if(stepTime != 0){
                timerLabel.text = holdText
                audioTimerHold.play()
            }
            break
        default:
            break;
        }
        
        step += 1
        
        if(stepTime != 0){
            //playsound(stepPlay: stepTime)
        }
        
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
    
    func playsound(stepPlay:Double){
        if(stepPlay == 0){
            audioTimer0.play()
        }
        else if(stepPlay == 1){
            audioTimer1.play()
        }
        else if(stepPlay == 2){
            audioTimer2.play()
        }
        else if(stepPlay == 3){
            audioTimer3.play()
        }
        else if(stepPlay == 4){
            audioTimer4.play()
        }
        else if(stepPlay == 5){
            audioTimer5.play()
        }
        else if(stepPlay == 6){
            audioTimer6.play()
        }
        else if(stepPlay == 7){
            audioTimer7.play()
        }
        else if(stepPlay == 8){
            audioTimer8.play()
        }
        else{
            //audioTimer0.play()
        }
    }
    

    func StopTimerNotification(){
        timer.invalidate()
    }
}
