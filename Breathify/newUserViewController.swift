//
//  newUserViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-29.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class newUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: Properties
    
    var pickerData: [String] = [String]()
    var user: UserProfile = UserProfile()
    
    // MARK: Outlets
    
    @IBOutlet weak var GenderPicker: UIPickerView!
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var NameField: UITextField!
    
    // MARK: Actions
    
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
        user.gender = pickerData[row]
        print(pickerData[row])
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
