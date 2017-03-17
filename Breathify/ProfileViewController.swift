//
//  ProfileViewController.swift
//  Breathify
//
//  Created by Princess Macanlalay on 3/12/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // Temporary hardcoded user
    var userprofile:UserProfile = UserProfile(name:"Joe Joe", username:"JoeX2", password:"abc123", email:"joejoe@email.com", id:1234, gender:"Male", optStatus:true, onlineStatus:true)

    // Variables labels to display user information
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var optStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = userprofile.name
        usernameLabel.text = userprofile.username
        emailLabel.text = userprofile.email
        genderLabel.text = userprofile.gender
        if (userprofile.optStatus == true){
            optStatusLabel.text = "Online"
        }
        else {
            optStatusLabel.text = "Local"
        }
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

}
