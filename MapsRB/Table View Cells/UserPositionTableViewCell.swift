//
//  UserPositionTableViewCell.swift
//  MapsRB
//
//  Created by HAMZA on 11/05/2019.
//  Copyright © 2019 HAMZA. All rights reserved.
//

import UIKit

class UserPositionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
