//
//  ExerciseViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-05.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    var nameText:String = ""
    var ratingText:String = ""
    var exercise:Exercise = Exercise()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        nameLabel.text = nameText
//        ratingLabel.text = ratingText + " / 5"

        nameLabel.text = exercise.name
        ratingLabel.text = "\(exercise.rating) / 5"
        descriptionTextView.text = exercise.description
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
