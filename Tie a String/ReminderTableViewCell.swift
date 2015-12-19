//
//  ReminderTableViewCell.swift
//  Tie a String
//
//  Created by Johnny on 12/19/15.
//  Copyright © 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
  
  @IBOutlet weak var reminderImage: UIImageView!
  @IBOutlet weak var reminderLabel: UILabel!
  @IBOutlet weak var expireDateLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
