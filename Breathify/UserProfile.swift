//
//  UserProfile.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class UserProfile {
    
    var name:String
    var username:String
    var email:String
    var password:String // used for "Remember me" option
    var id:Int
    var gender:String
    var optStatus:Bool
    var onlineStatus:Bool
    var profilePicture: UIImage
    //var exerciseHistory:ExerciseHistory
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
//        self.exerciseHistory = ExerciseHistory()
        //self.friendList = FriendList()
        self.profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
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
//        self.exerciseHistory = ExerciseHistory()
        //self.friendList = FriendList()
        self.profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
    }
    
    
}
