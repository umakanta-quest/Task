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
        
        //stausLabel.textColor = .white
        stausLabel.backgroundColor = .clear
        stausLabel.layer.cornerRadius = 2
        stausLabel.layer.borderWidth = 1
        stausLabel.layer.borderColor = UIColor.green.cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



