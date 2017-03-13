//
//  ExerciseViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-05.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    var exercise:Exercise = Exercise()
    
    // Rating star assets
    let filledStar = UIImage(named: "filled_star")
    let emptyStar = UIImage(named: "empty_star")
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var btnRating1: UIButton!
    @IBOutlet weak var btnRating2: UIButton!
    @IBOutlet weak var btnRating3: UIButton!
    @IBOutlet weak var btnRating4: UIButton!
    @IBOutlet weak var btnRating5: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        nameLabel.text = exercise.name
        descriptionTextView.text = exercise.description
        updateRating(rating: exercise.rating)
    }
    
    // Change the rating of the exercise and update rating star states
    func updateRating(rating:Int) {
        exercise.rating = rating
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "timerSelect") {
            let newView = segue.destination as! TimerBasedViewController
            
            newView.exercise = self.exercise
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
