//
//  NotificationsTableViewCell.swift
//  GradNext
//
//  Created by Aravind on 5/21/17.
//  Copyright © 2017 swathi. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageViews: UIImageView!

    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
