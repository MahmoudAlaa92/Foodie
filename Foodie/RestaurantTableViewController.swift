//
//  RestaurantTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 24/06/2024.
//

import UIKit

class RestaurantTableViewController: UITableViewController  {
    
    lazy var dataSource = configureDataSource()
   
    enum Section {
        case all
    }
    
    var restaurantNames = [
        "Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant",
        "Po's Atelier", "BourkeStreet Bakery" , "Haigh's Chocolate",
        "Palomino Espresso", "Upstate","Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves",
        "Cafe Lore", "Confessional","Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"
    ]
    
    var restaurantImages = [
    "cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"
    ]
    
    var restaurantLocations = [
        "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "HongKong", "Hong Kong", "Sydney", "Sydney", "Sydney",
    "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"
    ]
    var restaurantTypes = [
        "Coffee & Tea Shop", "Cafe", "Tea House", "Austrian/ Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames ,toSection: .all)
        
        dataSource.apply(snapshot ,animatingDifferences: false)
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
        
    func configureDataSource() -> UITableViewDiffableDataSource<Section ,String> {
        
        let cellIdentifier = "datacell"
        
        let dataSource = UITableViewDiffableDataSource<Section ,String> (
            tableView: tableView) { tableView, indexPath, restaurantName in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell else {
                    return UITableViewCell()
                }
                cell.nameLabel.text = self.restaurantNames[indexPath.row]
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                cell.typeLable.text = self.restaurantTypes[indexPath.row]
                cell.imageCell.image = UIImage(named: self.restaurantImages[indexPath.row])
                return cell
            }
        return dataSource
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vcBase = RestaurantTableViewController()
//        let vc = RestaurantTwoTableViewController()
//        dismiss(animated: true)
//        present(vc ,animated: true)
//    }
}
