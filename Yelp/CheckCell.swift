//
//  CheckCell.swift
//  Yelp
//
//  Created by Huynh Tri Dung on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CheckCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var filterText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
