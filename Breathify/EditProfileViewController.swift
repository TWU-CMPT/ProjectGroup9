//
//  EditProfileViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-18.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var usernameField: UITextField!
    
    // MARK: Properties
    var user: UserProfile = UserProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameField.text = user.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        let name = usernameField.text
        user.name = name!
        usernameField.resignFirstResponder()
    }

    // Exit software Keyboard when user presses Done form the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // Exit the software keyboard if the user touches the view that is not the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "createOnlineUser") {
            let newView = segue.destination as! CreateOnlineUserViewController
            newView.userprofile = user
        }
        if (segue.identifier == "login") {
            let newView = segue.destination as! LoginViewController
            newView.userprofile = user
        }
    }
 

}
