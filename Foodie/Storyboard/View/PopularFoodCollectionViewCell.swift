//
//  PopularFoodCollectionViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 12/09/2024.
//

import UIKit

class PopularFoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageOfLabel: UIImageView!{
        didSet{
            imageOfLabel.layer.cornerRadius = 15
            imageOfLabel.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
