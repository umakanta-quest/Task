//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Umakanta Sahoo on 13/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var stausLabel: UILabel!
    @IBOutlet weak var complexityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
