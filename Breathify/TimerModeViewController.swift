//
//  TimerModeViewController.swift
//  Breathify
//
//  Created by Ziyou Xu on 17/3/21.
//  Copyright © 2017年 Group Nein. All rights reserved.
//

import UIKit

class TimerModeViewController: UIViewController {
    
    var exercise:Exercise = Exercise()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pressHoldMode") {
            let newView = segue.destination as! TimerBasedViewController
            
            newView.exercise = self.exercise
        
        }
        else if(segue.identifier == "timerNormalMode") {
            let newView = segue.destination as! TimerBasedNormalMode
            
            newView.exercise = self.exercise
            
        }
    }
    
}
