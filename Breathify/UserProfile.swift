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
    
    var name:String
    var uid: String
    var gender:String
    var email:String?
    var password:String? // used for "Remember me" option
    var profilePicture: UIImage
    //var exerciseHistory:ExerciseHistory
    //var friendList:[FriendList] = []
    
    // Basic constructor
    init() {
        self.name = ""
        self.gender = ""
        self.uid = ""
        //self.optStatus = false
//        self.exerciseHistory = ExerciseHistory()
        //self.friendList = FriendList()
        self.profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
    }
    
    init(name:String, uid: String, password:String, email:String, gender:String) {
        self.name = name
        self.email = email
        self.password = password
        self.gender = gender
        self.uid = uid
        //self.optStatus = optStatus
//        self.exerciseHistory = ExerciseHistory()
        //self.friendList = FriendList()
        self.profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
    }
    
    init(authData: FIRUser, gender: String) {
        name = authData.displayName!
        uid = authData.uid
        email = authData.email
        profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
        self.gender = gender
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "gender": gender,
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
}
