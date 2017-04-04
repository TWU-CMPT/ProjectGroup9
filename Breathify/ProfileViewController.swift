//
//  ProfileViewController.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Properties
    
    var user: UserProfile = UserProfile()
    var selectedIndexPath = -1
    
    // table cells
    var profileData:[[String]] = [["Friends", "Settings", "Log In", "Log Out", "Register"]]
    let profileHeader:[String] = ["Account"]
    var cellIdentifiers:[[String]] = [["FriendList", "settings", "logIn", "userSelect","createOnlineUser"]]
    
    // MARK: Outlets
    
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var ProfileTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load in user from Tab Bar Controller
        let tbvc = self.tabBarController as? TabViewController
        user = (tbvc?.user)!
        selectedIndexPath = (tbvc?.selectedIndexPath)!
        
        // Set user's name Label
        nameLabel.text = user.name
        ProfilePicture.image = user.profilePicture
        
        if(FIRAuth.auth()?.currentUser != nil) {
            profileData = [["Friends", "Settings", "Log out"]]
            cellIdentifiers = [["FriendList", "settings", "userSelect"]]
        }
        ProfileTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        cell.textLabel?.text = profileData[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return profileHeader[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = cellIdentifiers[indexPath.section][indexPath.row]
        self.performSegue(withIdentifier: vc, sender: nil)
    }
    
    // On returning to table view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Reload data that may have changed in detailed view
        nameLabel.text = user.name
        ProfilePicture.image = user.profilePicture
        
        ProfileTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    
    @IBAction func rewindToProfile(segue: UIStoryboardSegue) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "settings") {
            let newView = segue.destination as! EditProfileViewController
            newView.user = user
        }
        else if (segue.identifier == "logIn") {
            let newView = segue.destination as! LoginViewController
            newView.user = user
        }
        else if (segue.identifier == "userSelect") {
            if FIRAuth.auth()?.currentUser != nil {
                do {
                    try FIRAuth.auth()?.signOut()

                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
        else if (segue.identifier == "createOnlineUser") {
            let newView = segue.destination as! CreateOnlineUserViewController
            newView.user = user
        }
        else if (segue.identifier == "FriendList") {
            let newView = segue.destination as! FriendListViewController
            newView.user = user
        }
    }
}
