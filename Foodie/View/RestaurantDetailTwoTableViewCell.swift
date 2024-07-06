//
//  RestaurantDetailTwoTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 04/07/2024.
//

import UIKit

class RestaurantDetailTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var addressTitle: UILabel!{
        didSet{
            addressTitle.numberOfLines = 0
            addressTitle.text = addressTitle.text?.uppercased()
            addressTitle.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var addresText: UILabel!{
        didSet{
            addresText.numberOfLines = 0
            addresText.adjustsFontForContentSizeCategory = true
        }
    }
    
    @IBOutlet weak var phoneTitle: UILabel!{
        didSet{
            phoneTitle.numberOfLines = 0
            phoneTitle.text = phoneTitle.text?.uppercased()
            phoneTitle.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var phoneText: UILabel!{
        didSet{
            phoneText.numberOfLines = 0
            phoneText.adjustsFontForContentSizeCategory = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
