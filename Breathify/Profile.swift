//
//  Profile.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class Profile {
    
    // Required fields: username, id, optStatus
    // Optional fields: name, gender
    var name:String?
    var username:String
    var id:Int
    var gender:String?
    var optStatus:Bool
    
    init(username:String, id:Int, optStatus:Bool) {
        self.username = username
        self.id = id
        self.optStatus = optStatus
    }
    
    init(name:String, username:String, id:Int, gender:String, optStatus:Bool) {
        self.name = name
        self.username = username
        self.id = id
        self.gender = gender
        self.optStatus = optStatus
    }
}
