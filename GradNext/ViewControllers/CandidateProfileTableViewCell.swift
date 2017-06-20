//
//  CandidateProfileTableViewCell.swift
//  candidateProfile
//
//  Created by Aravind on 5/16/17.
//  Copyright © 2017 Aravind. All rights reserved.
//

import UIKit

class CandidateProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var lblAddress: UILabel!

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
