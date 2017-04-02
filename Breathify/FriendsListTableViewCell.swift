//
//  FriendsListTableViewCell.swift
//  Breathify
//
//  Created by Keith Chan on 2017-04-01.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class FriendsListTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
