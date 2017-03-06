//
//  Feedback.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-05.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class Feedback {

    var username:String
    var rating:Int
    var comment:String?
    
    init(username:String, rating:Int, comment:String) {
        self.username = username
        self.rating = rating
        self.comment = comment
    }
}
