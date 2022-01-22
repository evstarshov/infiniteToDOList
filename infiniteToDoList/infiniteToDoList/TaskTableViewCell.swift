//
//  TaskTableViewCell.swift
//  toDoList
//
//  Created by Евгений Старшов on 22.01.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTask(with task: TaskProtocol) {
        nameLabel.text = task.name
        descriptionLabel.text = task.description
        
    }
    
}
