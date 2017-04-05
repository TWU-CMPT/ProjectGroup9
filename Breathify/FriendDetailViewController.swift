//
//  FriendDetailViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-04-01.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class FriendDetailViewController: UIViewController {

    // MARK: Properties
    
    var friend: UserProfile = UserProfile()
    let storage = FIRStorage.storage()
    
    // MARK: Outlets
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var GenderLabel: UILabel!
    
    // Sets the colour font of the status bar to be white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NameLabel.text = friend.name
        GenderLabel.text = friend.gender
        
        let imageRef = storage.reference().child("images/\(friend.key).jpg")
        imageRef.data(withMaxSize: 10 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error downloading:\(error)")
            }
            else {
                self.ProfilePicture.image = UIImage(data: data!)
            }
            
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
