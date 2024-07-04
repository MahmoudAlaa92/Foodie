//
//  RestaurantDetailViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 01/07/2024.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: HeaderRestaurantDetailView!
    
    var restaurant: Restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        headerView.restaurantName.text = restaurant.name
        headerView.restaurantType.text = restaurant.type
        
        let heartImage = restaurant.isFavorite ? UIImage(systemName: "heart.fill")  : UIImage(systemName: "heart")
        
        headerView.restaurantFavorite.setImage(heartImage, for: .normal)
        headerView.restaurantFavorite.tintColor = restaurant.isFavorite ? .systemYellow : .white
        
        navigationItem.largeTitleDisplayMode = .never
        tableView.separatorStyle = .none
    }
    
}

//MARK: - UIRestaurantDetailsTableViewDelegate

extension RestaurantDetailViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDescriptionTableViewCell.self), for: indexPath) as? RestaurantDescriptionTableViewCell else{
                return UITableViewCell()
            }
            cell.descriptionLabel.text = restaurant.description
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTwoTableViewCell.self), for: indexPath) as? RestaurantDetailTwoTableViewCell else{
                return UITableViewCell()
            }
            
            cell.addressTitle.text = "Address"
            cell.addresText.text = restaurant.location
            cell.phoneTitle.text = "Phone"
            cell.phoneText.text = restaurant.phone
            
            return cell
        default:
            fatalError("Error in RestaurantDetailsTableViewDelegate")
        }
    }
    
    
    
}
