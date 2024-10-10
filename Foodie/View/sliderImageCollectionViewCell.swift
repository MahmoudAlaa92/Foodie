//
//  sliderImageCollectionViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 20/08/2024.
//

import UIKit

class sliderImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!{
        didSet{
            imageCell.layer.cornerRadius = 25
            imageCell.layer.masksToBounds = true
            imageCell.clipsToBounds = true
            imageCell.contentMode = .scaleAspectFill
        }
    }
    
}
