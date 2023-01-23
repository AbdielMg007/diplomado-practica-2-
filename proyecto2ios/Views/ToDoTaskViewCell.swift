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
        let font: UIFont = UIFont(name: "Helvetica" , size: 16.0) ?? UIFont()
        let pm: UIFontMetrics = UIFontMetrics(forTextStyle: .subheadline)
        taskTitle.font = pm.scaledFont(for: font)
        taskTitle.adjustsFontForContentSizeCategory = true
    }

}

