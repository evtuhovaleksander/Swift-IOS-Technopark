//
//  CrashCell.swift
//  RAT
//
//  Created by Kirill on 3/18/17.
//  Copyright © 2017 RAT. All rights reserved.
//

import UIKit

class CrashCell: UITableViewCell {

    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var shortDecription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
