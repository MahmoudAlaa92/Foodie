//
//  FilterTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 10/10/2024.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            imgView.layer.cornerRadius = 15
            imgView.layer.masksToBounds = true
            imageView?.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
