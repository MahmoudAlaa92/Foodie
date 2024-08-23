//
//  ElementsCollectionViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 22/08/2024.
//

import UIKit

class ElementsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    @IBOutlet weak var dimView: UIView!{
        didSet{
            dimView.layer.cornerRadius = 10
            dimView.layer.masksToBounds = true
            dimView.clipsToBounds = true
        }
    }
}
