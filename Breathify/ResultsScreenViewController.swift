//
//  ResultsScreenViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-04-03.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ResultsScreenViewController: UIViewController {

    // MARK: Properties
    
    var user: UserProfile = UserProfile()
    let ref = FIRDatabase.database().reference(withPath: "Exercise")

    // Rating star assets
    let filledStar = UIImage(named: "filled_star")
    let emptyStar = UIImage(named: "empty_star")
    
    var exercise:Exercise?
    var score:Int?
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var commentField: UITextView!
    @IBOutlet weak var btnRating1: UIButton!
    @IBOutlet weak var btnRating2: UIButton!
    @IBOutlet weak var btnRating3: UIButton!
    @IBOutlet weak var btnRating4: UIButton!
    @IBOutlet weak var btnRating5: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scoreLabel.text = "Score: \(score!)"
        
    }
    
    
    
    @IBAction func didPressSubmit(_ sender: Any) {
        
        
        // If user is logged in, update FIREBASE
        if FIRAuth.auth()?.currentUser != nil {
            
            let update = ["username": user.name,
                          "rating": exercise?.rating ?? 5,
                          "comment": commentField.text] as [String : Any]
            
            let childUpdate = ["/" + (exercise?.key)! + "/feedback/" + (FIRAuth.auth()?.currentUser?.uid)!: update]
            
            ref.updateChildValues(childUpdate)
            
            let feedbackRef = ref.child((exercise?.key)!).child("feedback")
            
            var numUsers: Double = 0
            var sumRating: Double = 0
            var average: Double = 0
            
            feedbackRef.observe(.value, with: { snapshot in
                
                var feedbackItem = Feedback(username: "", rating: 0, comment: "")
                
                for item in snapshot.children {
                    feedbackItem = Feedback(snapshot: item as! FIRDataSnapshot)
                    numUsers += 1
                    sumRating += Double(feedbackItem.rating)
                }
                
                average = sumRating/numUsers
                
                self.ref.child("/" + (self.exercise?.key)! + "/avgRating").setValue(average)
            })
        }
        
    }
    
    // Change the rating of the exercise and update rating star states
    func updateRating(rating:Int) {
        exercise!.rating = rating

        btnRating1.setImage(emptyStar, for: .normal)
        btnRating2.setImage(emptyStar, for: .normal)
        btnRating3.setImage(emptyStar, for: .normal)
        btnRating4.setImage(emptyStar, for: .normal)
        btnRating5.setImage(emptyStar, for: .normal)
        
        switch (exercise!.rating) {
        case 1:
            btnRating1.setImage(filledStar, for: .normal)
            break
        case 2:
            btnRating1.setImage(filledStar, for: .normal)
            btnRating2.setImage(filledStar, for: .normal)
            break
        case 3:
            btnRating1.setImage(filledStar, for: .normal)
            btnRating2.setImage(filledStar, for: .normal)
            btnRating3.setImage(filledStar, for: .normal)
            break
        case 4:
            btnRating1.setImage(filledStar, for: .normal)
            btnRating2.setImage(filledStar, for: .normal)
            btnRating3.setImage(filledStar, for: .normal)
            btnRating4.setImage(filledStar, for: .normal)
            break
        case 5:
            btnRating1.setImage(filledStar, for: .normal)
            btnRating2.setImage(filledStar, for: .normal)
            btnRating3.setImage(filledStar, for: .normal)
            btnRating4.setImage(filledStar, for: .normal)
            btnRating5.setImage(filledStar, for: .normal)
            break
        default:
            break
        }
    }

    
    @IBAction func didRate1(_ sender: Any) {
        updateRating(rating:1)
    }
    @IBAction func didRate2(_ sender: Any) {
        updateRating(rating:2)
    }
    @IBAction func didRate3(_ sender: Any) {
        updateRating(rating:3)
    }
    @IBAction func didRate4(_ sender: Any) {
        updateRating(rating:4)
    }
    @IBAction func didRate5(_ sender: Any) {
        updateRating(rating:5)
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
