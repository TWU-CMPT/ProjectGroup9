//
//  UserProfile.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class Profile {
    
    // Required fields: name, username, id, gender, optStatus
    var name:String
    var username:String
    var email:String //require storing password too?
    var id:Int
    var gender:String
    var optStatus:Bool
    //var exerciseHistory:[ExerciseHistory]?
    //var friendList:[FriendList]?
    
    init(name:String, username:String, email:String, id:Int, gender:String, optStatus:Bool) {
        self.name = name
        self.username = username
        self.email = email
        self.id = id
        self.gender = gender
        self.optStatus = optStatus
    }
    
}
