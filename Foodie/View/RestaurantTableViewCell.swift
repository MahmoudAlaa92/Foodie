//
//  RestaurantTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 24/06/2024.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!{
        didSet{
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet var locationLabel: UILabel!{
        didSet{
            locationLabel.numberOfLines = 0
        }
    }
    @IBOutlet var typeLable: UILabel!{
        didSet{
            typeLable.numberOfLines = 0
        }
    }
    @IBOutlet var imageCell: UIImageView!{
        didSet{
            imageCell.layer.cornerRadius = 20
            imageCell.clipsToBounds = true
            imageCell.layer.masksToBounds  = true
            imageCell.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var favoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
