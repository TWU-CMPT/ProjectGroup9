//
//  Exercise.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-05.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class Exercise {

    var name:String
    var rating:Int
    var avgRating:Float?
    var description:String
    var feedback:[Feedback]?
    
    init() {
        self.name = ""
        self.rating = 0
        self.description = ""
    }
    
    init(name:String, rating:Int, description:String) {
        self.name = name
        self.rating = rating
        self.description = description
    }
    
    init(name:String, rating:Int, avgRating:Float, description:String, feedback:[Feedback]) {
        self.name = name
        self.rating = rating
        self.avgRating = avgRating
        self.description = description
        self.feedback = feedback
    }
}
