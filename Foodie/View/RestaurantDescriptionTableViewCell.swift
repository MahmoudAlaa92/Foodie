//
//  RestaurantDescriptionTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 04/07/2024.
//

import UIKit

class RestaurantDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet{
            descriptionLabel.numberOfLines = 0
            descriptionLabel.adjustsFontForContentSizeCategory = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
