//
//  newUserViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-29.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import os.log
import Firebase
import FirebaseAuth

class newUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: Properties
    
    var pickerData: [String] = [String]()
    var user: UserProfile?
    var selectedGender = "Male"
    var email: String?
    var password: String?
    
    // MARK: Outlets
    
    @IBOutlet weak var GenderPicker: UIPickerView!
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var BasicUserButton: UIButton!
    @IBOutlet weak var OnlineUserButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func BasicContinue(_ sender: Any) {
        performSegue(withIdentifier: "BasicUser", sender: nil)
    }
    
    @IBAction func OnlineContinue(_ sender: Any) {
        let alertController = UIAlertController(title: "Register", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: { _ in
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]
            
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user,error) in
                
                if error == nil {
                    print("You have successfuly signed up")
                    
                    self.email = emailField.text
                    self.password = passwordField.text
                    
                    self.performSegue(withIdentifier: "OnlineUser", sender: nil)
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        })
        
        alertController.addTextField { textEmail in
            textEmail.placeholder = "Email"
        }
        
        alertController.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Password"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    @IBAction func selectPhoto(_ sender: UITapGestureRecognizer) {
        
        // Hide keyboard
        NameField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated:true, completion: nil)
        
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        BasicUserButton.isEnabled = false
        OnlineUserButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ContinueButtonState()
    }
    
    // MARK: UIImagePickerController Functions
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //dismiss the picker if the user cancels
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        ProfilePicture.image = resizeImage(image: selectedImage, newWidth: 128)
        dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    // MARK: UIPickerView Protocol
    
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
        // set user's gender from UIPickerView
        selectedGender = pickerData[row]
    }
    
    // Sets the colour font of the status bar to be white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

        NameField.delegate = self
        
        self.GenderPicker.delegate = self
        self.GenderPicker.dataSource = self
        
        pickerData = ["Male", "Female", "Transgender", "Other", "Prefer not to answer"]
        
        ContinueButtonState()
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
        
        // Configure the destination view controller only when either continue button is pressed.
        if segue.identifier == "BasicUser" {
            
            user = UserProfile(name: NameField.text!, gender: selectedGender, profilePicture: ProfilePicture.image!)
        }
            
        else if segue.identifier == "OnlineUser" {
            
            user = UserProfile(name: NameField.text!, password: password!, email: email!, gender: selectedGender, profilePicture: ProfilePicture.image!)
        }
        
    }
    
    // MARK: Private methods
    
    private func ContinueButtonState() {
        let text = NameField.text ?? ""
        BasicUserButton.isEnabled = !text.isEmpty
        OnlineUserButton.isEnabled = !text.isEmpty
    }
}
