//
//  UserSelectViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-20.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class UserSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let reuseIdentifier = "userCell"
    
    // MARK: Outlets
    @IBOutlet weak var UserCollectionView: UICollectionView!
    
    // MARK: Temporary hard-coded users
    
    var users = [UserProfile(name:"Joe Joe", username:"JoeX2", password:"testtest", email:"test@test.com", id:1234, gender:"Male", optStatus:true, onlineStatus:true), UserProfile(name:"Jim Jim", username:"JimX2", password:"testtest", email:"test2@test.com", id:1234, gender:"Male", optStatus:true, onlineStatus:true)]

    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! UserCollectionViewCell
        
        // Change cell appearance depending on user's name and picture
        cell.userName.text = users[indexPath.row].name
        cell.userPicture.image = users[indexPath.row].profilePicture
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Change value of selectedRow depending on which cell was selected
        print("You selected cell #\(indexPath.item)!")
        
        performSegue(withIdentifier: "UserSelected", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserSelected", let sender = sender {
            
            if sender is UserCollectionViewCell {
                let cell = sender as? UserCollectionViewCell
                let indexPath = UserCollectionView.indexPath(for: cell!)
                
                // lets the tab bar controller know which user has been selected
                if let indexPath = indexPath {
                    let vc = segue.destination as? TabViewController
                    vc?.user = users[indexPath.row]
                }
            }
        }
    }


}
