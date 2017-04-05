//
//  FriendsListTableViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-04-01.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FriendsListTableViewController: UITableViewController {

    // MARK: Properties
    
    var user: UserProfile = UserProfile()
    var updatedFriendList: [String]?
    var Friends: [UserProfile] = []
    let ref = FIRDatabase.database().reference(withPath: "User")
    
    // MARK: Outlets
    
    @IBOutlet weak var FriendsListTableView: UITableView!
    
    // MARK: Actions
    
    
    @IBAction func BackButton(_ sender: Any) {
        performSegue(withIdentifier: "Home", sender: nil)
    }
    
    @IBAction func AddFriend(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Follow a Friend", message: "Enter your friend's email address", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { (alert: UIAlertAction) in
            let emailField = alertController.textFields![0] as UITextField
            
            self.ref.queryOrdered(byChild: "email").queryStarting(atValue: emailField.text).queryEnding(atValue: emailField.text).observe(.value, with: { snapshot in
                // friend already exists in friend's list
                if self.user.friendList.contains(emailField.text!) {
                    let alertController2 = UIAlertController(title: "Error", message: "You are already following \(emailField.text!)", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    
                    alertController2.addAction(OKAction)
                    
                    self.present(alertController2, animated: true, completion: nil)
                }
                
                else if snapshot.exists() {
                    print(snapshot.value!)
                    var newFriends: [UserProfile] = []
                    for item in snapshot.children {
                        let friendItem = UserProfile(snapshot: item as! FIRDataSnapshot)
                        newFriends.append(friendItem)
                    }
                    self.Friends += newFriends
                    let newIndexPath = IndexPath(row: self.user.friendList.count, section: 0)
                    self.user.friendList.append(emailField.text!)
                    self.FriendsListTableView.insertRows(at: [newIndexPath], with: .automatic)
                    
                }
                else {
                    let alertController2 = UIAlertController(title: "Error", message: "User does not exist", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    
                    alertController2.addAction(OKAction)
                    
                    self.present(alertController2, animated:true, completion: nil)
                }
                
            })
        })
        
        alertController.addTextField()
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let nvc = self.navigationController as! FriendListViewController
        user = nvc.user
        
        for email in user.friendList {
            
            ref.queryOrdered(byChild: "email").queryStarting(atValue: email).queryEnding(atValue: email).observe(.value, with: { snapshot in
                
                var newFriends: [UserProfile] = []
                
                for item in snapshot.children {
                    let friendItem = UserProfile(snapshot: item as! FIRDataSnapshot)
                    newFriends.append(friendItem)
                }
                
                self.Friends = newFriends
                self.FriendsListTableView.reloadData()
            })
            
        }
    }
    
    // Sets the colour font of the status bar to be white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return Friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsListTableViewCell

        cell.nameLabel.text = Friends[indexPath.row].name
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            user.friendList.remove(at: indexPath.row)
            Friends.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "FriendDetail") {
            if let indexPath:IndexPath = FriendsListTableView.indexPathForSelectedRow {
                let newView = segue.destination as! FriendDetailViewController
                newView.friend = Friends[indexPath.row]
            }
        }
        else if segue.identifier == "Home" {
            updatedFriendList = user.friendList
        }
    }
    

}
