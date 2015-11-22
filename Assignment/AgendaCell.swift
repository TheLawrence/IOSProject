//
//  AgendaCell.swift
//  Assignment
//
//  Created by Bryan Chau on 2015-11-21.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit

class AgendaCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var agenda: Agenda! {
        didSet {
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .LongStyle
            typeLabel.text = agenda.type
            nameLabel.text = agenda.name
            dateLabel.text = dateFormatter.stringFromDate((agenda.date)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
