//
//  TabViewController.swift
//  Breathify
//
//  Created by Keith Chan on 2017-03-20.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    // MARK: Properties
    
    // This is the user that has been selected from previous view
    var user: UserProfile = UserProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(user.name)
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
