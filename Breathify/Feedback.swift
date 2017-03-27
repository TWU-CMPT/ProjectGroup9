//
//  Feedback.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-05.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Feedback {

    var username:String
    var rating:Int
    var comment:String?
    var key: String?
    var ref: FIRDatabaseReference?
    
    init(username:String, rating:Int, comment:String) {
        self.username = username
        self.rating = rating
        self.comment = comment
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        username = snapshotValue["username"] as! String
        rating = snapshotValue["rating"] as! Int
        comment = snapshotValue["comment"] as? String
        key = snapshot.key
        ref = snapshot.ref
    }
}
