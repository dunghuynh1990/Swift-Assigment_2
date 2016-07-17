//
//  BusinessCell.swift
//  Yelp
//
//  Created by Huynh Tri Dung on 7/15/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var business : Business! {
        didSet {
            restaurantNameLabel.text = business.name
            if business.imageURL != nil {
                thumbNail.setImageWithURL(business.imageURL!)
            } else {
                thumbNail.image = UIImage(named: "placeholder")
            }
            
            categoryLabel.text = business.categories
            distanceLabel.text = business.distance
            reviewLabel.text = "\(business.reviewCount!) Reviews"
            addressLabel.text = business.address
            ratingImageView.setImageWithURL(business.ratingImageURL!)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbNail.layer.cornerRadius = 5
        thumbNail.clipsToBounds = true
        restaurantNameLabel.preferredMaxLayoutWidth = restaurantNameLabel.frame.width
        addressLabel.preferredMaxLayoutWidth = addressLabel.frame.size.width
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        restaurantNameLabel.preferredMaxLayoutWidth = restaurantNameLabel.frame.width
        addressLabel.preferredMaxLayoutWidth = addressLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
