//
//  FirstViewController.swift
//  Breathify
//
//  Created by Hans Kim on 2017-03-01.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var exerciseTableView: UITableView!

    var selectedRow = 0
    var exercises:[Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

        exercises.append(Exercise(name:"4/7/8 Exercise", rating:5, description:"Description 1"))
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
        let newView = segue.destination as! ExerciseViewController
        
        if (segue.identifier == "cellSelect") {
            if let indexPath:IndexPath = exerciseTableView.indexPathForSelectedRow {
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

