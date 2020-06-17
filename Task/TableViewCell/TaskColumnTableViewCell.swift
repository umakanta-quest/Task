//
//  TaskColumnTableViewCell.swift
//  Task
//
//  Created by Umakanta Sahoo on 17/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//

import UIKit

class TaskColumnTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var stausLabel: UILabel!
    @IBOutlet weak var complexityLabel: UILabel!
    
    //===============================================================
    //MARK: - Cell LifeCycle
    //===============================================================
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        applyStyles()
    }
    
    
    func applyStyles() {
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        
        createDateLabel.adjustsFontSizeToFitWidth = true
        createDateLabel.minimumScaleFactor = 0.5
        complexityLabel.adjustsFontSizeToFitWidth = true
        complexityLabel.minimumScaleFactor = 0.5
        stausLabel.adjustsFontSizeToFitWidth = true
        stausLabel.minimumScaleFactor = 0.5
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
