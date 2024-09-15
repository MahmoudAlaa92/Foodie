//
//  HeaderRestaurantDetailView.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 04/07/2024.
//

import UIKit

class HeaderRestaurantDetailView: UIView {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!{
        didSet{
            if let customFont = UIFont(name: "Nunito-Bold", size: 40){
                restaurantName.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
            }
            restaurantName.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var restaurantType: UILabel!{
        didSet{
            if let customFont = UIFont(name: "Nunito-Bold", size: 20){
                restaurantType.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
            }
            restaurantType.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var restaurantFavorite: UIButton!
    
        @IBOutlet weak var ratingImageView: UIImageView!
}
