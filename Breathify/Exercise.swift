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
    var sequence:[[Any]]?
    
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
    
    init(name:String, rating:Int, description:String, sequence:String) {
        self.name = name
        self.rating = rating
        self.description = description
        self.sequence = parseSequence(sequence: sequence)
    }
    
    init(name:String, rating:Int, avgRating:Float, description:String, feedback:[Feedback]) {
        self.name = name
        self.rating = rating
        self.avgRating = avgRating
        self.description = description
        self.feedback = feedback
    }
    
    func parseSequence(sequence:String) -> [[Any]] {
        var seq:[[Any]] = []
        let instructions = sequence.components(separatedBy: ",")
        
        for step in instructions {
            let instruction = step.startIndex
            let duration = step.index(after: step.startIndex)..<step.endIndex
            let x:[Any] = [step[instruction], Int(step[duration])!]
            seq.append(x)
        }
        
        return seq
    }
}
