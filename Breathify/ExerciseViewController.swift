//
//  ExerciseViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-05.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: Properties
    
    var exercise:Exercise = Exercise()
    var user: UserProfile = UserProfile()
    var feedback: [Feedback] = []
    var ref = FIRDatabase.database().reference(withPath: "Exercise")
    
    // Rating star assets
    let filledStar = UIImage(named: "filled_star")
    let emptyStar = UIImage(named: "empty_star")
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var btnRating1: UIButton!
    @IBOutlet weak var btnRating2: UIButton!
    @IBOutlet weak var btnRating3: UIButton!
    @IBOutlet weak var btnRating4: UIButton!
    @IBOutlet weak var btnRating5: UIButton!
    @IBOutlet weak var CommentTableView: UITableView!
    
    // Change the rating of the exercise and update rating star states
    func updateRating(rating:Int) {
        exercise.rating = rating
        //feedback = Feedback(username: user.name, rating: rating, comment: "")
        
        btnRating1.setImage(emptyStar, for: .normal)
        btnRating2.setImage(emptyStar, for: .normal)
        btnRating3.setImage(emptyStar, for: .normal)
        btnRating4.setImage(emptyStar, for: .normal)
        btnRating5.setImage(emptyStar, for: .normal)
        
        switch (exercise.rating) {
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

    // Actions for rating buttons
    @IBAction func didRate1(_ sender: Any) {
        updateRating(rating: 1)
    }
    @IBAction func didRate2(_ sender: Any) {
        updateRating(rating: 2)
    }
    @IBAction func didRate3(_ sender: Any) {
        updateRating(rating: 3)
    }
    @IBAction func didRate4(_ sender: Any) {
        updateRating(rating: 4)
    }
    @IBAction func didRate5(_ sender: Any) {
        updateRating(rating: 5)
    }

    // MARK: Table View Protocol
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedback.count
    }
    
     // Number of sections
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
     // Get section header
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Comments"
        }
    
    // Set cell attributes
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentsTableViewCell
        
        cell.CommentTextView.text = feedback[indexPath.row].comment
        cell.NameLabel.text = feedback[indexPath.row].username
        cell.RatingLabel.text = "\(feedback[indexPath.row].rating)"
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nameLabel.text = exercise.name
        descriptionTextView.text = exercise.description
        updateRating(rating: exercise.rating)
        
        let feedbackRef = ref.child(exercise.key).child("feedback")
        
        feedbackRef.observe(.value, with: { snapshot in
            var newFeedback: [Feedback] = []
            
            for item in snapshot.children {
                let feedbackItem = Feedback(snapshot: item as! FIRDataSnapshot)
                newFeedback.append(feedbackItem)
            }
            
            self.feedback = newFeedback
            self.CommentTableView.reloadData()
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "timerSelect") {
            let newView = segue.destination as! TimerBasedViewController
            
            newView.exercise = self.exercise
        }
        else if (segue.identifier == "timerMode") {
            let newView = segue.destination as! TimerModeViewController
            newView.exercise = self.exercise
        }
        else if (segue.identifier == "gameMode") {
            let newView = segue.destination as! GameBasedViewController
            newView.exercise = self.exercise
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
