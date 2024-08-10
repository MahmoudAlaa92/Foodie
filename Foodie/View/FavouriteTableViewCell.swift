//
//  FavouriteTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 09/08/2024.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    
  
    @IBOutlet weak var imageCell: UIImageView!{
        didSet{
            imageCell.layer.cornerRadius = 20
            imageCell.layer.masksToBounds = true
            imageCell.clipsToBounds = true
            imageCell.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!{
        didSet{
            locationLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var typeLabel: UILabel!{
        didSet{
            typeLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var fovouriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
