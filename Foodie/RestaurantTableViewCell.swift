//
//  RestaurantTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 24/06/2024.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLable: UILabel!
    @IBOutlet var imageCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewAttributies()
        self.tintColor = .systemYellow
    }
    
    func imageViewAttributies (){
        imageCell.layer.cornerRadius = 20
        imageCell.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
}
