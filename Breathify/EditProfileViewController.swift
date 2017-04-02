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
import FirebaseDatabase

class EditProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    var user: UserProfile = UserProfile()
    var selectedGender: String = ""
    var pickerData: [String] = []
    let ref = FIRDatabase.database().reference(withPath: "User")
    let storage = FIRStorage.storage()
    
    // MARK: Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var GenderPicker: UIPickerView!
    @IBOutlet weak var ProfilePicture: UIImageView!

    // MARK: Actions
    
    @IBAction func selectPhoto(_ sender: UITapGestureRecognizer) {
        
        // Hide keyboard
        usernameField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated:true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any) {
        // If user's name field is not blank
        if (usernameField.text != "") {
            user.setName(newName: usernameField.text!)
            user.setProfilePicture(newPicture: ProfilePicture.image!)
            
            // If gender was changed inside of UIPicker View
            if selectedGender != "" {
                user.setGender(newGender: selectedGender)
            }

            // If user is authenticated, update user database
            if FIRAuth.auth()?.currentUser != nil {
                let userRef = ref.child((FIRAuth.auth()?.currentUser?.uid)!)
                self.user.key = (FIRAuth.auth()?.currentUser?.uid)!
                userRef.setValue(user.toAnyObject())
                
                // upload profile picture to Firebase Storage
                let data = UIImageJPEGRepresentation(user.profilePicture, 1)
                storage.reference().child("images/\(user.key).jpg").put(data!, metadata: nil)
            }
            
            performSegue(withIdentifier: "Save", sender: nil)
        }
        else {
            let alert = UIAlertController(title: "Oh no!", message: "Make sure you fill in all fields", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(OKAction)
            
            self.present(alert, animated:true, completion: nil)
        }
    }

    // MARK: UIPickerController Delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //dismiss the picker if the user cancels
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        ProfilePicture.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerView Protocol
    
    // the number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        selectedGender = pickerData[row]
    }
    
    // MARK: Default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameField.text = user.name
        ProfilePicture.image = user.profilePicture
        
        //Gender UIPickerView Setup
        
        self.GenderPicker.delegate = self
        self.GenderPicker.dataSource = self
        
        pickerData = ["Male", "Female", "Transgender", "Other", "Prefer not to answer"]
        
        let index = pickerData.index(of: user.gender)
        GenderPicker.selectRow(index!, inComponent: 0, animated: true)
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
