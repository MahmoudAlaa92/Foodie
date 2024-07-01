//
//  RestaurantDetailViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 01/07/2024.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restauranNameLabel: UILabel! {
        didSet{
            if let customFont = UIFont(name: "Nunito-Bold", size: 40){
                restauranNameLabel.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: customFont)
            }
        }
    }
    @IBOutlet weak var restaurantLocationLabel: UILabel!
    @IBOutlet weak var restaurantTypeLabel: UILabel! {
        didSet{
            if let customFont = UIFont(name: "Nunito-Bold", size: 20){
                restaurantTypeLabel.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: customFont)
            }
        }
    }
    
    @IBOutlet weak var dimView: UIView!
    
    var restaurantImageName = ""
    var restauranName = ""
    var restaurantLocation = ""
    var restaurantType = ""
    var restaurantDiscription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantImageView.image = UIImage(named: restaurantImageName)
        restauranNameLabel.text = restauranName
        restaurantLocationLabel.text = restaurantLocation
        restaurantTypeLabel.text = restaurantType
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
}
