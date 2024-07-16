//
//  RestaurantDetailViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 01/07/2024.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    var restaurant = Restaurant()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var headerView: HeaderRestaurantDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView.headerImageView.image = restaurant.image
        headerView.restaurantName.text = restaurant.name
        headerView.restaurantType.text = restaurant.type
        
        if let rateImage = restaurant.rating?.image{
            headerView.ratingImageView.image = UIImage(named: rateImage)
        }
        
        let heartImage = restaurant.isFavorite ? UIImage(systemName: "heart.fill")  : UIImage(systemName: "heart")
        
        headerView.restaurantFavorite.setImage(heartImage, for: .normal)
        headerView.restaurantFavorite.tintColor = restaurant.isFavorite ? .systemYellow : .white
        
        navigationItem.backButtonTitle = ""
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // StatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


//MARK: - UIRestaurantDetailsTableViewDelegate

extension RestaurantDetailViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDescriptionTableViewCell.self), for: indexPath) as? RestaurantDescriptionTableViewCell else{
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.descriptionLabel.text = restaurant.summary
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTwoTableViewCell.self), for: indexPath) as? RestaurantDetailTwoTableViewCell else{
                return UITableViewCell()
            }
            
            cell.addressTitle.text = "Address"
            cell.addresText.text = restaurant.location
            cell.phoneTitle.text = "Phone"
            cell.phoneText.text = restaurant.phone
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as? RestaurantDetailMapCell else{
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configer(location: restaurant.location)
            return cell
        default:
            fatalError("Error in RestaurantDetailsTableViewDelegate")
        }
    }
    // prepare MapViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "MapViewController":
            if let destinationVC = segue.destination as? MapViewController{
                destinationVC.restaurant = self.restaurant
            }
        case "showReview":
            if let destinationVC = segue.destination as? ReviewViewController{
                destinationVC.restaurant = self.restaurant
            }
        default:
            break
        }
    }
    
    //unwindSegue
    @IBAction func close(segue: UIStoryboardSegue){
        dismiss(animated: true)
    }
    
    // click to any rate as you like
    @IBAction func rating(segue: UIStoryboardSegue){
        
        guard let identifier = segue.identifier else{
            return
        }
        dismiss(animated: true, completion: {
            if let rating = Restaurant.Rating(rawValue: identifier) {
                self.restaurant.rating = rating
                self.headerView.ratingImageView.image = UIImage(named: rating.image)
            }
            let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.headerView.ratingImageView.transform = scaleTransform
            self.headerView.ratingImageView.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping
                           : 0.3, initialSpringVelocity: 0.5) {
                self.headerView.ratingImageView.transform = .identity
                self.headerView.ratingImageView.alpha = 1
            }
        })
    }
}
