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
    
    // MARK: Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: Actions
    @IBAction func createUser(_ sender: Any) {
        if emailField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                
                // Register successful
                if error == nil {
                    print("You have successfully signed up")
                    self.user.setEmail(newEmail: self.emailField.text!)
                    self.user.setPassword(newPassword: self.passwordField.text!)
                    
                    let userRef = self.ref.child((user?.uid)!)
                    userRef.setValue(self.user.toAnyObject())
                    
                    // upload profile picture to Firebase Storage
                    let data = UIImageJPEGRepresentation(self.user.profilePicture, 1)
                    self.storage.reference().child("images/\(FIRAuth.auth()?.currentUser?.uid).jpg").put(data!, metadata: nil)
                    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.emailField.text = user.email
        self.passwordField.text = user.password
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
            let vc = segue.destination as! TabViewController
            vc.user = user
        }
    }
    

}
