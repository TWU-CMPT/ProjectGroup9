//
//  ProfileViewController.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
//    // Temporary hardcoded user
//    var userprofile:UserProfile = UserProfile(name:"Joe Joe", username:"JoeX2", password:"testtest", email:"test@test.com", id:1234, gender:"Male", optStatus:true, onlineStatus:true)
    var userprofile: UserProfile = UserProfile()

    // Variables labels to display user information
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load in user from Tab Bar Controller
        let tbvc = self.tabBarController as? TabViewController
        userprofile = (tbvc?.user)!
        
        // Set user's name Label
        nameLabel.text = userprofile.name
    }
    
    // On returning to table view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Reload data that may have changed in detailed view
        nameLabel.text = userprofile.name
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
        newView.user = userprofile
     }
}


}
