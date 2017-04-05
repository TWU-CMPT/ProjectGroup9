//
//  Contact.swift
//  Breathify
//
//  Created by Keith Chan on 2017-04-04.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Contact {
    
    var name: String
    var days: String
    var hours: String
    var phone: String
    
    init(name: String, days: String, hours: String, phone: String) {
        self.name = name
        self.days = days
        self.hours = hours
        self.phone = phone
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        days = snapshotValue["days"] as! String
        hours = snapshotValue["hours"] as! String
        phone = snapshotValue["phone"] as! String
        
    }
    
}
