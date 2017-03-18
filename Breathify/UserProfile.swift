//
//  UserProfile.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class UserProfile {
    
    // Required fields: name, username, password, id, gender, optStatus, onlineStatus
    var name:String
    var username:String
    var email:String
    var password:String // used for "Remember me" option
    var id:Int
    var gender:String
    var optStatus:Bool
    var onlineStatus:Bool
    var exerciseHistory:[ExerciseHistory] = []
    //var friendList:[FriendList] = []
    
    init() {
        self.name = ""
        self.username = ""
        self.email = ""
        self.password = ""
        self.id = 0
        self.gender = ""
        self.optStatus = false
        self.onlineStatus = false
    }
    
    init(name:String, username:String, password:String, email:String, id:Int, gender:String, optStatus:Bool, onlineStatus:Bool) {
        self.name = name
        self.username = username
        self.email = email
        self.password = password
        self.id = id
        self.gender = gender
        self.optStatus = optStatus
        self.onlineStatus = onlineStatus
    }
    
    // function to add history for Game Based Trainer
    func addGameHistory(exerciseID:Int, score:Int) {
        let newGameHistory = ExerciseHistory(type:"game")
        newGameHistory.exerciseID = exerciseID
        newGameHistory.gameScore = score
        //newGameHistory.heartData = heartdata
        
        self.exerciseHistory.append(newGameHistory)
    }
    
    // function to add history for Timer Based Trainer
    func addTimerHistory(exerciseID:Int, score:Int){
        let newTimerHistory = ExerciseHistory(type:"timer")
        newTimerHistory.exerciseID = exerciseID
        newTimerHistory.timerScore = score
        //newTimerHistory.heartData = heartdata
        
        self.exerciseHistory.append(newTimerHistory)
    }
    
    
    
}
