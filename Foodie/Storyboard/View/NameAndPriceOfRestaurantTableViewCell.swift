//
//  HeaderTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 15/09/2024.
//

import UIKit

class NameAndPriceOfRestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodePrice: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
 
    var orderCount = 0{
        didSet{
            orderNumber.text = "\(orderCount)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
}
