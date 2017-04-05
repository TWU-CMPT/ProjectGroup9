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
    var updatedUser: UserProfile?
    
    // MARK: Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var GenderPicker: UIPickerView!
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var SaveButton: UIBarButtonItem!

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
        user.name = usernameField.text!
        user.gender = selectedGender
        user.profilePicture = ProfilePicture.image!
        
        performSegue(withIdentifier: "Save", sender: nil)
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
        selectedGender = pickerData[row]
    }
    
    // Sets the colour font of the status bar to be white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameField.text = user.name
        ProfilePicture.image = user.profilePicture
        selectedGender = user.gender
        usernameField.delegate = self
        
        //Gender UIPickerView Setup
        
        self.GenderPicker.delegate = self
        self.GenderPicker.dataSource = self
        
        pickerData = ["Male", "Female", "Transgender", "Other", "Prefer not to answer"]
        
        let index = pickerData.index(of: user.gender)
        GenderPicker.selectRow(index!, inComponent: 0, animated: true)
        
        updateButtonStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        SaveButton.isEnabled = false
    }

    // Exit software Keyboard when user presses Done form the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonStatus()
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
            updatedUser = user
        }
    }
 
    // MARK: Private Methods
    
    private func updateButtonStatus() {
        let text = usernameField.text ?? ""
        SaveButton.isEnabled = !text.isEmpty
    }
    
}
