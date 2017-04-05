//
//  ContactTableViewCell.swift
//  Breathify
//
//  Created by Keith Chan on 2017-04-04.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
