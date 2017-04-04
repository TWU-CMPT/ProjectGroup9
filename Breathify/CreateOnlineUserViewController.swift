//
//  CreateOnlineUserViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-18.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CreateOnlineUserViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    var user: UserProfile = UserProfile()
    let ref = FIRDatabase.database().reference(withPath: "User")
    let storage = FIRStorage.storage()
    var updatedUser: UserProfile?
    
    // MARK: Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
    
    // MARK: Actions
    @IBAction func createUser(_ sender: Any) {

        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            
            // Register successful
            if error == nil {
                print("You have successfully signed up")
                self.user.setEmail(newEmail: self.emailField.text!)
                self.user.setPassword(newPassword: self.passwordField.text!)
                
                FIRAuth.auth()?.signIn(withEmail: self.user.email, password: self.user.password, completion: { (user,error) in
                    
                    if(error == nil) {
                        print("You have successfully logged in")
                    }
                    else {
                        print("Login failed")
                    }
                    
                })

                self.performSegue(withIdentifier: "Home", sender: nil)
            }
            // Not successful
            else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }

    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        RegisterButton.isEnabled = false
    }
    
    // Exit software Keyboard when user presses Done form the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonStatus()
    }
    
    // Exit the software keyboard if the user touches the view that is not the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
        
        // Do any additional setup after loading the view.
        
        updateButtonStatus()
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

        if segue.identifier == "Home" {
            updatedUser = UserProfile(key: user.key, name: user.name, gender: user.gender, email: user.email, password: user.password, profilePicture: user.profilePicture, friendList: user.friendList)
        }
        
    }
    
    // MARK: Private Methods
    
    private func updateButtonStatus() {
        
        let text = emailField.text ?? ""
        let text2 = passwordField.text ?? ""
        
        RegisterButton.isEnabled = (!text.isEmpty && !text2.isEmpty)
    }
}
