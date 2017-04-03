//
//  Exercise.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-05.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Exercise {
    
    var name:String
    var rating:Int
    var description:String
    var avgRating:Float?
    var sequence:[[Any]]?
    var repetitions:Int?
    var key: String
    let ref: FIRDatabaseReference?
    
    
    // Default constructor
    init() {
        self.name = ""
        self.rating = 0
        self.description = ""
        self.key = ""
        self.ref = nil
    }
    
    // Constructor for offline sequence-less exercise
    init(name:String, rating:Int, description:String) {
        self.name = name
        self.rating = rating
        self.description = description
        self.key = ""
        self.ref = nil
    }
    
    // Constructor for offline exercise
    init(name:String, rating:Int, description:String, sequence:String, repetitions:Int) {
        self.name = name
        self.rating = rating
        self.description = description
        self.repetitions = repetitions
        self.key = ""
        self.ref = nil
        self.sequence = parseSequence(sequence: sequence)
    }
    
    // Constructor for online sequence-less exercise
    init(name:String, rating:Int, avgRating:Float, description:String, feedback:[Feedback]) {
        self.name = name
        self.rating = rating
        self.avgRating = avgRating
        self.description = description
        self.ref = nil
        self.key = ""
    }
    
    // Constructor for Firebase exercises
    init(snapshot: FIRDataSnapshot) {
        
        // set FIRDatabaseReference's
        ref = snapshot.ref
        // use snapshotValue to initialize properties
        let snapshotValue = snapshot.value as! [String: AnyObject]
        key = snapshot.key
        name = snapshotValue["name"] as! String
        self.rating = 0
        avgRating = snapshotValue["avgRating"] as? Float
        description = snapshotValue["description"] as! String
        repetitions = snapshotValue["repetitions"] as? Int
        let unparsedSequence: String = snapshotValue["sequence"] as! String
        self.sequence = parseSequence(sequence: unparsedSequence)
    }
    
    // Parses sequence from String
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
