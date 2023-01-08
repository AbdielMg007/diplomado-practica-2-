//
//  ToDoTaskViewCell.swift
//  proyecto2ios
//
//  Created by Abdiel Mg on 28/12/22.
//

import UIKit

class ToDoTaskViewCell: UITableViewCell {
    
    
    @IBOutlet var taskTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

