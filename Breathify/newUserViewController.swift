//
//  newUserViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-29.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class newUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: Properties
    
    var pickerData: [String] = [String]()
    var user: UserProfile = UserProfile()
    
    // MARK: Outlets
    
    @IBOutlet weak var GenderPicker: UIPickerView!
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var NameField: UITextField!
    
    // MARK: Actions
    
    @IBAction func selectPhoto(_ sender: UITapGestureRecognizer) {
        
        // Hide keyboard
        NameField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated:true, completion: nil)
        
    }

    @IBAction func Continue(_ sender: Any) {
        
        if NameField.text == "" {
            let alertController = UIAlertController(title: "Who are you?", message: "Please enter your name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .cancel)
            
            alertController.addAction(OKAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Would you like to register?", message: "Registered users will be able to connect with friends", preferredStyle: .alert)
            let onlineAction = UIAlertAction(title: "Yes", style: .default, handler: {action in self.performSegue(withIdentifier: "OnlineUser", sender: nil)})
            let offlineAction = UIAlertAction(title: "No", style: .default, handler: {action in self.performSegue(withIdentifier: "Home", sender: nil)})
            
            alertController.addAction(offlineAction)
            alertController.addAction(onlineAction)
            
            user.name = NameField.text!
            user.profilePicture = ProfilePicture.image!
            
            present(alertController, animated:true, completion:nil)
        }
    }
    
    // MARK: UIImagePickerController Delegate
    
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
    
    // UIPickerView Protocol
    
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
        user.gender = pickerData[row]
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

        self.GenderPicker.delegate = self
        self.GenderPicker.dataSource = self
        
        pickerData = ["Male", "Female", "Transgender", "Other", "Prefer not to answer"]
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
        
        if (segue.identifier == "Home") {
            let vc = segue.destination as! TabViewController
            vc.user = user
        }
        else if (segue.identifier == "Online") {
            let vc = segue.destination as! CreateOnlineUserViewController
            vc.user = user
        }
        
    }
    

}
