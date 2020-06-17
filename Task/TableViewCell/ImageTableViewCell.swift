//
//  ImageTableViewCell.swift
//  Task
//
//  Created by Umakanta Sahoo on 16/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//

import UIKit
protocol ImageTableViewCellDelegate: class {
    func ImageTableViewCellDelegate(_ cell: ImageTableViewCell, deleteButtonAction sender: UIButton)
}

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: ImageTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteImage(_ sender: UIButton) {
        delegate?.ImageTableViewCellDelegate(self, deleteButtonAction: sender)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
