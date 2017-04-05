//
//  ResourceLibraryViewController.swift
//  Breathify
//
//  Created pmacanla on 4/4/17.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ResourceLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var user: UserProfile = UserProfile()
    
    let resourceData:[String] = ["SFU Health & Counselling Services","SFU Health & Conselling Resources","SFU Events & Programs Calendar","SFU Health & Conselling Volunteer","SFU Healthy Campus Community"]
    
    let resourcesLinks:[String] = ["https://www.sfu.ca/students/health/", "http://www.sfu.ca/students/health/resources.html", "http://www.sfu.ca/students/health/events/Events-Calendar.html","http://www.sfu.ca/students/health/volunteer.html","http://www.sfu.ca/healthycampuscommunity.html"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell", for: indexPath)
        cell.textLabel?.text = resourceData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = resourcesLinks[indexPath.row]
        //UIApplication.shared.openURL(URL(string: url)!)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: url)!)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
}
