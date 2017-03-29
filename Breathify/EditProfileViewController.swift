//
//  EditProfileViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-18.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditProfileViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var usernameField: UITextField!
    
    // MARK: Properties
    var user: UserProfile = UserProfile()
    
    // MARK: Actions
    
    @IBAction func Save(_ sender: Any) {
        if (usernameField.text != "") {
            user.name = usernameField.text!
            
            performSegue(withIdentifier: "Save", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameField.text = user.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        // pass on user to next views
        if (segue.identifier == "Save") {
            let newView = segue.destination as! TabViewController
            newView.user = user
        }
    }
 

}
