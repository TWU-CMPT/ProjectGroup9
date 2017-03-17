//
//  ExerciseHistory.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/17/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ExerciseHistory {
    
    enum TrainerType {
        case game
        case timer
    }
    
    var type:TrainerType?
    var exerciseID:Int
    var gameScore:Int?
    var timerScore:Int?
    var date:Date
    // var heartData:[]?
    
    // Initialization for storing Gamer History
    init(type:String){
        if (type == "game") {
            self.type = TrainerType.game
        }
        else if (type == "timer") {
            self.type = TrainerType.timer
        }
        self.exerciseID = -1
        self.date = Date()
        self.gameScore = -1
        self.timerScore = -1
        //self.heartData = ???
    }
    
    // Returns the type trainer of the history
    func getType() ->String {
        if (self.type == TrainerType.game) {
            return "game"
        }
        else {
            return "timer"
        }
    }
    
    
    
}
