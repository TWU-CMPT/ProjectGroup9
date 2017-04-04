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
    
    // MARK: Outlets
    
    @IBOutlet weak var ProfilePicture: UIImageView!
    
    // table cells
    let profileData:[[String]] = [["Friends", "Settings", "Log In", "Log Out", "Register"]]
    let profileHeader:[String] = ["Account"]
    let cellIdentifiers:[[String]] = [["FriendList", "settings", "logIn", "userSelect","createOnlineUser"]]
    
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

    // Variables labels to display user information
    @IBOutlet weak var nameLabel: UILabel!
    
    // Sets the colour font of the status bar to be white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load in user from Tab Bar Controller
        let tbvc = self.tabBarController as? TabViewController
        user = (tbvc?.user)!
        
        // Set user's name Label
        nameLabel.text = user.name
        ProfilePicture.image = user.profilePicture
    }
    
    // On returning to table view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Reload data that may have changed in detailed view
        nameLabel.text = user.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    
                    // go back to Home (maybe change to go back to user select page?)
                    /*
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabHome")
                    present(vc, animated: true, completion: nil)
                    */
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
            let newView = segue.destination as! FriendsListTableViewController
            newView.user = user
        }
    }
}
