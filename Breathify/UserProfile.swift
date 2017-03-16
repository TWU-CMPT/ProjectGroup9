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
    private var password:String // used for "Remember me" option
    var id:Int
    var gender:String
    var optStatus:Bool
    var onlineStatus:Bool
    //var exerciseHistory:[ExerciseHistory]?
    //var friendList:[FriendList]?
    
    init(name:String, username:String, email:String, password:String, id:Int, gender:String, optStatus:Bool, onlineStatus:Bool) {
        self.name = name
        self.username = username
        self.email = email
        self.password = password
        self.id = id
        self.gender = gender
        self.optStatus = optStatus
        self.onlineStatus = onlineStatus
    }
    
    // Should be used for Remember Me option
    func getPassword() -> String {
        return password
    }
    
    
}
