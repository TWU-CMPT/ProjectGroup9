//
//  TabViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-20.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import os.log
import Firebase
import FirebaseAuth
import FirebaseStorage

class TabViewController: UITabBarController {

    // MARK: Properties
    
    // This is the user that has been selected from previous view
    var user: UserProfile = UserProfile()
    var users: [UserProfile] = []
    var selectedIndexPath = -1
    let ref = FIRDatabase.database().reference(withPath: "User")
    let storage = FIRStorage.storage()
    
    // MARK: Actions
    
    @IBAction func unwindToTabBar(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.source as? CreateOnlineUserViewController, let updatedUser = sourceViewController.updatedUser {
            
            users[selectedIndexPath] = updatedUser
            saveUsers()
            
            user = users[selectedIndexPath]
            if FIRAuth.auth()?.currentUser != nil {
                updateDatabase(user: user)
                uploadProfilePicture(user: user)
            }
        }
        else if let sourceViewController = segue.source as? LoginViewController, let updatedUser = sourceViewController.updatedUser {
            
            users[selectedIndexPath] = updatedUser
            saveUsers()
            
            user = users[selectedIndexPath]
            if FIRAuth.auth()?.currentUser != nil {
                updateDatabase(user: user)
            }        }
        else if let sourceViewController = segue.source as? LoginViewController, let updatedUser = sourceViewController.updatedUser {
            
            users[selectedIndexPath] = updatedUser
            saveUsers()
            
            user = users[selectedIndexPath]
            if FIRAuth.auth()?.currentUser != nil {
                updateDatabase(user: user)
            }        }
        else if let sourceViewController = segue.source as? FriendsListTableViewController, let updatedFriendList = sourceViewController.updatedFriendList{
            
            users[selectedIndexPath].friendList = updatedFriendList
            saveUsers()
            
            user = users[selectedIndexPath]
//            if FIRAuth.auth()?.currentUser != nil {
//                updateDatabase(user: user)
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: Private Methods
    
    private func saveUsers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(users, toFile: UserProfile.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Users successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func updateDatabase(user: UserProfile) {
        let userRef = ref.child(user.key)
        userRef.setValue(user.toAnyObject())
    }
    
    private func uploadProfilePicture(user: UserProfile) {
        let data = UIImageJPEGRepresentation(user.profilePicture, 1)
        storage.reference().child("images/" + user.key + ".jpg").put(data!, metadata: nil)
    }
}
