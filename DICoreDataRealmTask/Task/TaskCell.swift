//
//  TaskCell.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 15/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(withTask task: Task) {
        nameLabel.text = task.name
    }
}
