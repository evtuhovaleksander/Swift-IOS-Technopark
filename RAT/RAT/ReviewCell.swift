//
//  ReviewCell.swift
//  RAT
//
//  Created by Kirill on 4/13/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var reviewDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
