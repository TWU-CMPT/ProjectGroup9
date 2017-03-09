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
    var timer = Timer()
    var breathIn:Double = 4.0
    var breathHold:Double = 7.0
    var breathOut:Double = 8.0
    var breathSwitch = 1
    
    var exercise:Exercise = Exercise()
    
    @IBOutlet weak var ProgressBarView: MBCircularProgressBarView!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var BreathLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func TimerStart(_ sender: UIButton) {
        time = breathIn
        TimerLabel.text = String(Int(time))
        BreathLabel.text = String("Breathe In")
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.action), userInfo: nil, repeats: true)
        
        UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.ProgressBarView.value = 100
        } , completion: ({finished in
            if(finished){
                UIView.animate(withDuration:0.0, delay: 7.0,options:.curveEaseOut,animations:{
                    self.ProgressBarView.value = 99
                } , completion: ({finished in
                    if(finished){
                        UIView.animate(withDuration:8.0, delay:0.0, options:.curveEaseOut,animations: {
                            self.ProgressBarView.value = 0
                        })
                        
                    }}))
            }
            
        }))
    }
    
    @IBAction func TimerStop(_ sender: UIButton) {
        timer.invalidate()
        time = breathIn
        TimerLabel.text = String(Int(time))
        breathSwitch = 1
        BreathLabel.text = String("4/7/8 exercise")
        timer.invalidate()
    }
    
    func action()
    {
        if(time > 1){
            time -= 1
            TimerLabel.text = String(Int(time))
        }
        else{
            if(breathSwitch == 1){
                time = breathHold
                BreathLabel.text = String("Hold")
                TimerLabel.text = String(Int(time))
                breathSwitch = 2
            }
            else if(breathSwitch == 2){
                time = breathOut
                BreathLabel.text = String("Breathe Out")
                TimerLabel.text = String(Int(time))
                breathSwitch = 0
            }
            else if(breathSwitch == 0){
                time = breathIn
                BreathLabel.text = String("Breathe In")
                TimerLabel.text = String(Int(time))
                breathSwitch = 1
                timer.invalidate()
            }
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
