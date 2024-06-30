//
//  RestaurantTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 24/06/2024.
//

import UIKit

class RestaurantTableViewController: UITableViewController  {
    
    lazy var dataSource = configureDataSource()
    
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
    
    func configureDataSource() -> RestaurantDiffableDataSource {
        
        let cellIdentifier = "datacell"
        
        let dataSource = RestaurantDiffableDataSource (
            tableView: tableView) { tableView, indexPath, restaurantName in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell else {
                    return UITableViewCell()
                }
                cell.nameLabel.text = self.Restaurants[indexPath.row].name
                cell.locationLabel.text = self.Restaurants[indexPath.row].location
                cell.typeLable.text = self.Restaurants[indexPath.row].type
                cell.imageCell.image = UIImage(named: self.Restaurants[indexPath.row].image)
                cell.favoriteImage.isHidden = self.Restaurants[indexPath.row].isFavorite ? false : true
                
                return cell
            }
        return dataSource
    }
    
    // MARK: - UITableViewDelegate Protocol
    
    //didSelectRow
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        let reserve = { (action: UIAlertAction!) in
            let alert = UIAlertController(title: "sorry", message: "try in anoher time", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert ,animated: true)
        }
        
        let reserveAction = UIAlertAction(title: "resrveAction", style: .default, handler: reserve)
        
        //Mark as a fovorite
        let favoriteAction = UIAlertAction(title: "Mark as a fovorite", style: .default) { (action: UIAlertAction!) in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.Restaurants[indexPath.row].isFavorite = true
            cell.favoriteImage.image = UIImage(systemName: "heart.fill")
            cell.favoriteImage.isHidden = false
        }
        //Mark as unfovorite
        let unFavoriteAction = UIAlertAction(title: "Remove from favorite", style: .default){ (action: UIAlertAction!) in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.Restaurants[indexPath.row].isFavorite = false
            cell.favoriteImage.isHidden = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(reserveAction)
        optionMenu.addAction(favoriteAction)
        optionMenu.addAction(unFavoriteAction)
        optionMenu.addAction(cancelAction)
        
        // popOver
        if let popOver = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath){
                popOver.sourceView = cell
                popOver.sourceRect = cell.bounds
            }
        }
        present(optionMenu ,animated: true ,completion: nil)
    }
    
    // trailingSwipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
            //delete
        let deleteAtcion = UIContextualAction(style: .destructive, title: "Delete") { action, sourceview, completionHandler in
            
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.Restaurants.remove(at: indexPath.row)
            self.dataSource.apply(snapshot ,animatingDifferences: true)
            
            completionHandler(true)
        }
        //share
        let shareAction = UIContextualAction(style: .normal, title: "Share") { Action, sourceView, completionHandler in
            
            let defualtActivity = "Research for the restaurant"
            let activityControler: UIActivityViewController
            
            if let imageToShare = UIImage(named: restaurant.image){
                activityControler = UIActivityViewController(activityItems: [defualtActivity ,imageToShare], applicationActivities: nil)
            } else {
                activityControler =  UIActivityViewController(activityItems: [defualtActivity], applicationActivities: nil)
            }
            
            if let popOver = activityControler.popoverPresentationController {
                
                let cell = tableView.cellForRow(at: indexPath)
                
                popOver.sourceView = cell
                popOver.sourceRect = cell!.bounds
            }
            self.present(activityControler ,animated: true)
            completionHandler(true)
        }
        
        deleteAtcion.backgroundColor = UIColor.systemRed
        deleteAtcion.image = UIImage(systemName: "trash")
        shareAction.backgroundColor = .systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipConfiguration = UISwipeActionsConfiguration(actions: [deleteAtcion ,shareAction])
        return swipConfiguration
    }
    
    //leadingSwipe
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = self.Restaurants[indexPath.row].isFavorite
        let markAsFavorite = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHanedler in
            self.Restaurants[indexPath.row].isFavorite = favorite ? false : true
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            if favorite {
                cell.favoriteImage.isHidden = true
            }else{
                cell.favoriteImage.image = UIImage(systemName: "heart.fill")
                cell.favoriteImage.isHidden = false
            }
            completionHanedler(true)
        }
        
        favorite ? (markAsFavorite.image = UIImage(systemName: "heart.slash.fill")) :
        (markAsFavorite.image = UIImage(systemName: "heart.fill"))
        
        markAsFavorite.backgroundColor = .systemYellow
        markAsFavorite.image?.withTintColor(.white)
        
        let swipConfigration = UISwipeActionsConfiguration(actions: [markAsFavorite])
        return swipConfigration
    }
    
}
