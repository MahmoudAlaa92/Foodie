//
//  RestaurantTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 24/06/2024.
//

import UIKit

class RestaurantTableViewController: UITableViewController  {
    
    lazy var dataSource = configureDataSource()
    struct DiffableItem: Hashable {
        let id = UUID()
        let title: Int
    }
    enum Section {
        case all
    }
        
    var Restaurants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location:
        "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image:"homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
          Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "HongKong", image: "forkee", isFavorite: false),
          Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
          Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
          Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
          Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
          Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
          Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
          Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
          Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "NewYork", image: "waffleandwolf", isFavorite: false),
          Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
          Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
          Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
          Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
          Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
          Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
          Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(Restaurants ,toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        tableView.separatorStyle = .none
    }
    
    // MARK: - UITableView Diffable Data Source
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section ,Restaurant> {
        
        let cellIdentifier = "datacell"
        
        let dataSource = UITableViewDiffableDataSource<Section ,Restaurant> (
            tableView: tableView) { tableView, indexPath, restaurantName in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell else {
                    return UITableViewCell()
                }
                cell.nameLabel.text = self.Restaurants[indexPath.row].name
                cell.locationLabel.text = self.Restaurants[indexPath.row].location
                cell.typeLable.text = self.Restaurants[indexPath.row].type
                cell.imageCell.image = UIImage(named: self.Restaurants[indexPath.row].image)
                cell.accessoryType = self.Restaurants[indexPath.row].isFavorite ? .checkmark : .none
                return cell
            }
        return dataSource
    }
    
    // MARK: - UITableViewDelegate Protocol
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
      
        let reserve = { (action: UIAlertAction!) in
            let alert = UIAlertController(title: "sorry", message: "try in anoher time", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert ,animated: true)
        }
        
        let reserveAction = UIAlertAction(title: "resrveAction", style: .default, handler: reserve)
        
        let favoriteAction = UIAlertAction(title: "Mark as a fovorite", style: .default) { (action: UIAlertAction!) in
            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType =  .checkmark
            cell?.accessoryView = UIImageView(image: UIImage(systemName: "heart.fill"))
            self.Restaurants[indexPath.row].isFavorite = true
            
        }
        
        let unFavoriteAction = UIAlertAction(title: "Remove from favorite", style: .default){ (action: UIAlertAction!) in
            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType = .none
            cell?.accessoryView = nil
            self.Restaurants[indexPath.row].isFavorite = false
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(reserveAction)
        optionMenu.addAction(favoriteAction)
        optionMenu.addAction(unFavoriteAction)
        optionMenu.addAction(cancelAction)
        
        if let popOver = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath){
                popOver.sourceView = cell
                popOver.sourceRect = cell.bounds
            }
        }
        present(optionMenu ,animated: true ,completion: nil)
    }
    
}
