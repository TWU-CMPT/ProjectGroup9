//
//  ProfileViewController.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Properties
    
    var user: UserProfile = UserProfile()
    
    // table cells
    let profileData:[[String]] = [["Settings", "Log In", "Log Out"]]
    let profileHeader:[String] = ["Account"]
    let cellIdentifiers:[[String]] = [["settings", "logIn", "userSelect"]]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load in user from Tab Bar Controller
        let tbvc = self.tabBarController as? TabViewController
        user = (tbvc?.user)!
        
        // Set user's name Label
        nameLabel.text = user.name
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editProfile") {
            // pass on user to next view
            let newView = segue.destination as! EditProfileViewController
            newView.user = user
        }
        else if (segue.identifier == "settings") {
            let newView = segue.destination as! EditProfileViewController
            newView.user = user
        }
        else if (segue.identifier == "logIn") {
            let newView = segue.destination as! LoginViewController
            newView.userprofile = user
        }
    }
}
