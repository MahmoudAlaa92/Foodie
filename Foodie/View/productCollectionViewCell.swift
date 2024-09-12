//
//  productCollectionViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 12/09/2024.
//

import UIKit

class productCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!{
        didSet{
            productImage.layer.cornerRadius = 15
            productImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func favouriteBtn(_ sender: UIButton) {
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
    }
    
}
