//
//  AddToCartTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 15/09/2024.
//

import UIKit

class AddToCartTableViewCell: UITableViewCell {

    @IBOutlet weak var addBtn: UIButton!{
        didSet{
            addBtn.layer.cornerRadius = 12
            addBtn.layer.masksToBounds = true
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
