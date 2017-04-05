//
//  UserSelectViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-20.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import os.log
import Firebase
import FirebaseAuth

class UserSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let reuseIdentifier = "userCell"
    
    // MARK: Outlets
    
    @IBOutlet weak var UserCollectionView: UICollectionView!
    
    // MARK: Properties
    
    var users: [UserProfile] = []

    // MARK: Collection View Protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! UserCollectionViewCell
        
        // Change cell appearance depending on user's name and picture
        cell.userName.text = users[indexPath.row].name
        cell.userPicture.image = users[indexPath.row].profilePicture
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Change value of selectedRow depending on which cell was selected
        print("You selected cell #\(indexPath.item)!")
        
        performSegue(withIdentifier: "UserSelected", sender: self)
    }
    
    // Sets the colour font of the status bar to be white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let savedUsers = loadUsers() {
            users += savedUsers
        }
        else {
            users = loadSampleUser()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func rewindToOpening(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.source as? newUserViewController, let user = sourceViewController.user {
            
            let newIndexPath = IndexPath(item: users.count, section: 0)
            
            users.append(user)
            UserCollectionView.insertItems(at: [newIndexPath])
            
            saveUsers()
        }
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserSelected", let sender = sender {
            
            if sender is UserCollectionViewCell {
                let cell = sender as? UserCollectionViewCell
                let indexPath = UserCollectionView.indexPath(for: cell!)
                
                // lets the tab bar controller know which user has been selected
                if let indexPath = indexPath {
                    let vc = segue.destination as? TabViewController
                    let user = users[indexPath.row]
                    vc?.user = user
                    vc?.users = users
                    vc?.selectedIndexPath = indexPath.row
                    
                    // automatically sign user into firebase if email and password field works
                    if user.email != "" && user.password != "" {
                        LogIn(email: user.email, password: user.password)
                    }
                }
            }
        }
    }
    
    // MARK: Private Methods
    
    private func LogIn(email: String, password: String) {
        //log in
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            if error == nil {
                
                //Print into the console if successfully logged in
                print("You have successfully logged in")
                
            } else {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func saveUsers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(users, toFile: UserProfile.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Users successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }

    private func loadUsers() -> [UserProfile]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UserProfile.ArchiveURL.path) as? [UserProfile]
    }
    
    private func loadSampleUser() -> [UserProfile] {
        let sampleUsers = [UserProfile(name: "Sample User", password: "testtest", email: "test2@test.com", gender: "Male", profilePicture: #imageLiteral(resourceName: "DefaultProfileFace2"))]
        return sampleUsers
    }
}
