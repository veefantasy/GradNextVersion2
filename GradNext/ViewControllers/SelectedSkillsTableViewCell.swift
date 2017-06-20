//
//  SelectedSkillsTableViewCell.swift
//  searchBar
//
//  Created by Aravind on 5/15/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

import UIKit

class SelectedSkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
