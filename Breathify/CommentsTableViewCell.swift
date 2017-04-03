//
//  CommentsTableViewCell.swift
//  Breathify
//
//  Created by Keith Chan on 2017-04-02.
//  Copyright © 2017 Group Nein. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var CommentTextView: UITextView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var RatingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
