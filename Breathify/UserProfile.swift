//
//  UserProfile.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import os.log
import Firebase
import FirebaseAuth

class UserProfile: NSObject, NSCoding {

    // MARK: Properties
    
    var key: String
    var name:String
    var gender:String
    var email:String
    var password:String
    var profilePicture: UIImage
    //var exerciseHistory:ExerciseHistory
    var friendList:[String]
    let ref: FIRDatabaseReference?
    
    // MARK: Types
    
    struct PropertyKey {
        static let key = "key"
        static let name = "name"
        static let gender = "gender"
        static let email = "email"
        static let password = "password"
        static let profilePicture = "profilePicture"
        static let friendList = "friendList"
        static let ref = "ref"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    // MARK: Constructors
    
    override init() {
        self.key = ""
        self.name = ""
        self.gender = ""
        self.email = ""
        self.password = ""
        //self.exerciseHistory = ExerciseHistory()
        self.friendList = []
        self.profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
        self.ref = nil
    }
    
    // Basic User Constructor
    init(name: String, gender: String, profilePicture: UIImage) {
        self.key = ""
        self.name = name
        self.gender = gender
        self.email = ""
        self.password = ""
        self.profilePicture = profilePicture
        self.friendList = []
        self.ref = nil
    }
    
    // Online User Constructor
    init(name: String, password: String, email: String, gender: String, profilePicture: UIImage) {
        self.key = ""
        self.name = name
        self.gender = gender
        self.email = email
        self.password = password
        self.profilePicture = profilePicture
        self.friendList = []
        self.ref = nil
    }
    
    // Constructor for NSCoding
    init(key: String, name:String, gender:String, email:String, password:String, profilePicture: UIImage, friendList: [String]) {
        self.key = key
        self.name = name
        self.gender = gender
        self.email = email
        self.password = password
        self.profilePicture = profilePicture
        self.friendList = friendList
        self.ref = nil
    }
    
    // Constructor for loading friend's profiles from Firebase
    init(snapshot: FIRDataSnapshot) {
        ref = snapshot.ref
        let snapshotValue = snapshot.value as! [String: AnyObject]
        key = snapshotValue["key"] as! String
        name = snapshotValue["name"] as! String
        gender = snapshotValue["gender"] as! String
        email = snapshotValue["email"] as! String
        password = ""
        friendList = []
        profilePicture = #imageLiteral(resourceName: "Gender Neutral User-50")
    }
    
    // MARK: Methods
    
    // Function to turn into JSON String
    func toAnyObject() -> Any {
        return [
            "name": name,
            "email": email,
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
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: PropertyKey.key)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(gender, forKey: PropertyKey.gender)
        aCoder.encode(email, forKey: PropertyKey.email)
        aCoder.encode(password, forKey: PropertyKey.password)
        aCoder.encode(profilePicture, forKey: PropertyKey.profilePicture)
        aCoder.encode(friendList, forKey: PropertyKey.friendList)
        aCoder.encode(ref, forKey: PropertyKey.ref)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let key = aDecoder.decodeObject(forKey: PropertyKey.key) as? String
        let gender = aDecoder.decodeObject(forKey: PropertyKey.gender) as? String
        let email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String
        let password = aDecoder.decodeObject(forKey: PropertyKey.password) as? String
        let profilePicture = aDecoder.decodeObject(forKey: PropertyKey.profilePicture) as? UIImage
        let friendList = aDecoder.decodeObject(forKey: PropertyKey.friendList) as? [String]
        
        // Must call designated initializer
        self.init(key: key!, name: name, gender: gender!, email: email!, password: password!, profilePicture: profilePicture!, friendList: friendList!)
    }
}
