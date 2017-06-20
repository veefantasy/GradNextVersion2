//
//  TableViewCell.swift
//  Atlantatamilchurch
//
//  Created by Muthu Kumar M on 1/18/17.
//  Copyright © 2017 Atlantatamilchurch. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    //Leftview Header Cell
    @IBOutlet  var userImageView : UIImageView!
    @IBOutlet  var nameLabel : UILabel!
    @IBOutlet  var companyLabel : UILabel!

    
    //Leftview controller - Normal Cell
    @IBOutlet  var iconImageView : UIImageView!
    @IBOutlet  var menuLabel : UILabel!
    
    
    
    //Home View Controller  - Events
    
    @IBOutlet  var  dateLabel : UILabel!
    @IBOutlet  var  MeetingtitleLabel : UILabel!
    @IBOutlet  var  locationLabel : UILabel!
    
    //Loader Cell
    @IBOutlet  var activityIndicatior : UIActivityIndicatorView!
 

    //Contact us Viewcontroller
    @IBOutlet  var phoneNobutton  : UIButton!
    @IBOutlet  var phoneIconbutton  : UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
