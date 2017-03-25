//
//  FirstViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-01.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ExercisesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var exerciseTableView: UITableView!

    //MARK: Properties
    
    var selectedRow = 0
    var exercises:[Exercise] = []
    // Firebase database reference
    let ref = FIRDatabase.database().reference(withPath: "Exercise")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        exercises.append(Exercise(name:"4/7/8 Exercise", rating:5, description:"A simple breathing exercise that acts like a sleeping pill. Inhale through your nose for four seconds, hold your breath for seven seconds, then exhale through your mouth for eight seconds.  Feel relaxed in no time.\nInhale: 4\nHold: 7\nExhale: 8", sequence:"I4,H7,O8",repetitions: 2))

        ref.observe(.value, with: { snapshot in
            print(snapshot.value!)
            var newExercises: [Exercise] = []
            
            for item in snapshot.children {
                let exerciseItem = Exercise(snapshot: item as! FIRDataSnapshot)
                newExercises.append(exerciseItem)
            }
            
            self.exercises = newExercises
            self.exerciseTableView.reloadData()
        })
    }
    
    // On returning to table view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Reload data that may have changed in detailed view
        exerciseTableView.reloadData()
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return exercises.count
    }
    
    // Number of sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
//    }
    
    // Get section header
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return headers[section]
//    }
    
    // Set cell attributes
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExerciseCell

        cell.nameLabel.text = exercises[indexPath.row].name
        cell.ratingLabel.text = "\(exercises[indexPath.row].rating)"
        
        return cell
    }
    
    // Delegate row select
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(indexPath.section) | \(indexPath.row)")
//        
//        selectedSection = indexPath.section
//        selectedRow = indexPath.row
//    }
    
    // Preparing to change to detailed exercise view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "cellSelect") {
            if let indexPath:IndexPath = exerciseTableView.indexPathForSelectedRow {
                let newView = segue.destination as! ExerciseViewController
                
                selectedRow = indexPath.row
                newView.exercise = exercises[selectedRow]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

