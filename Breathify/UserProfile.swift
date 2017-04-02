//
//  UserProfile.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UserProfile {
    
    var key: String
    var name:String
    var gender:String
    var email:String?
    var password:String? // used for "Remember me" option
    var profilePicture: UIImage
    //var exerciseHistory:ExerciseHistory
    var friendList:[String] = []
    var PhotoURL: String?
    let ref: FIRDatabaseReference?
    
    // Basic constructor
    init() {
        self.key = ""
        self.name = ""
        self.gender = ""
        //self.optStatus = false
//        self.exerciseHistory = ExerciseHistory()
        //self.friendList = FriendList()
        self.profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
        self.ref = nil
    }
    
    init(name:String, password:String, email:String, gender:String, friendList: [String]) {
        self.key = ""
        self.name = name
        self.email = email
        self.password = password
        self.gender = gender
        //self.optStatus = optStatus
//        self.exerciseHistory = ExerciseHistory()
        //self.friendList = FriendList()
        self.profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
        self.friendList = friendList
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        ref = snapshot.ref
        let snapshotValue = snapshot.value as! [String: AnyObject]
        key = snapshotValue["key"] as! String
        name = snapshotValue["name"] as! String
        gender = snapshotValue["gender"] as! String
        email = snapshotValue["email"] as? String
        friendList = snapshotValue["friendList"] as! [String]
        profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
    }
    
    // Function to turn into JSON String
    func toAnyObject() -> Any {
        return [
            "name": name,
            "email": email ?? "",
            "friendList": friendList,
            "key": key,
            "gender": gender
        ]
    }
    
    // Changing properties
    func setName(newName: String) {
        self.name = newName
    }
    
    func setEmail(newEmail: String) {
        self.email = newEmail
    }
    
    func setPassword(newPassword: String) {
        self.password = newPassword
    }
    
    func setGender(newGender: String) {
        self.gender = newGender
    }
    
    func setProfilePicture(newPicture: UIImage) {
        self.profilePicture = newPicture
    }
    
    func setKey(key: String) {
        self.key = key
    }
}
