//
//  RestaurantTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 24/06/2024.
//

import UIKit
import SwiftData

protocol RestaurantDataStore{
    func fetchRestaurantData()
}

class RestaurantTableViewController: UITableViewController ,RestaurantDataStore  {
    
    lazy var dataSource = configureDataSource()
    
    var container: ModelContainer?
    var dataStore: RestaurantDataStore?
    
    var restaurants: [Restaurant] = []
    
    @IBOutlet var emptyRestaurantView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = try? ModelContainer(for: Restaurant.self)
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        
        if let apperance = navigationController?.navigationBar.standardAppearance {
            apperance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 45){
                apperance.titleTextAttributes = [.foregroundColor : UIColor(named: "NavigationBarTitle")!
                ]
                apperance.largeTitleTextAttributes =  [.foregroundColor : UIColor(named: "NavigationBarTitle")!, .font:customFont
                ]
            }
            navigationController?.navigationBar.standardAppearance = apperance
            navigationController?.navigationBar.compactAppearance = apperance
            navigationController?.navigationBar.scrollEdgeAppearance = apperance
        }
        
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = restaurants.count > 0 ? true : false
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
//        tableView.rowHeight = UITableView.automaticDimension

        fetchRestaurantData()
    }
// MARK: - Swift Data
    
    // Fetch restaurantData from DB
    func fetchRestaurantData(){
        let descriptor = FetchDescriptor<Restaurant>()
        
        restaurants = (try? container?.mainContext.fetch(descriptor)) ?? []
        updateSnapshot()
    }
    
    // update Snapshot
    func updateSnapshot(animationChange: Bool = false){
        var snapshot = NSDiffableDataSourceSnapshot<Section ,Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot ,animatingDifferences: true)
        
        tableView.backgroundView?.isHidden = (restaurants.count > 0) ? false : true
    }
    
    // viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Foodie"
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: - UITableView Diffable Data Source
    
    func configureDataSource() -> RestaurantDiffableDataSource {
        
        let cellIdentifier = "datacell"
        
        let dataSource = RestaurantDiffableDataSource (
            tableView: tableView) { tableView, indexPath, restaurantName in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell else {
                    return UITableViewCell()
                }
                cell.nameLabel.text = self.restaurants[indexPath.row].name
                cell.locationLabel.text = self.restaurants[indexPath.row].location
                cell.typeLable.text = self.restaurants[indexPath.row].type
                cell.imageCell.image = self.restaurants[indexPath.row].image
                cell.favoriteImage.isHidden = self.restaurants[indexPath.row].isFavorite ? false : true
                
                return cell
            }
        return dataSource
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
        dismiss(animated: true)
    }
    // MARK: - UITableViewDelegate Protocol
    
        // prepare showRestaurantDetails
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetails" {
            if let indexPath = tableView.indexPathForSelectedRow ,let destinationVC = segue.destination as? RestaurantDetailViewController {
                destinationVC.restaurant = restaurants[indexPath.row]
            }
        }else if segue.identifier == "addNewRestaurant" {
            if let navController = segue.destination as? UINavigationController ,
               let destinationVC = navController.topViewController as? NewRestaurantController{
                print("Added")
                destinationVC.dataStore = self
            }
        }
    }
    
    // didSelectRow
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        tableView.deselectRow(at: indexPath, animated: false)
    //
    //        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    //
    //        let reserve = { (action: UIAlertAction!) in
    //            let alert = UIAlertController(title: "sorry", message: "try in anoher time", preferredStyle: .alert)
    //            alert.addAction(UIAlertAction(title: "OK", style: .default))
    //            self.present(alert ,animated: true)
    //        }
    //
    //        let reserveAction = UIAlertAction(title: "resrveAction", style: .default, handler: reserve)
    //
    //        //Mark as a fovorite
    //        let favoriteAction = UIAlertAction(title: "Mark as a fovorite", style: .default) { (action: UIAlertAction!) in
    //            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
    //            self.Restaurants[indexPath.row].isFavorite = true
    //            cell.favoriteImage.image = UIImage(systemName: "heart.fill")
    //            cell.favoriteImage.isHidden = false
    //        }
    //        //Mark as unfovorite
    //        let unFavoriteAction = UIAlertAction(title: "Remove from favorite", style: .default){ (action: UIAlertAction!) in
    //            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
    //            self.Restaurants[indexPath.row].isFavorite = false
    //            cell.favoriteImage.isHidden = true
    //        }
    //
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    //
    //        optionMenu.addAction(reserveAction)
    //        optionMenu.addAction(favoriteAction)
    //        optionMenu.addAction(unFavoriteAction)
    //        optionMenu.addAction(cancelAction)
    //
    //        // for ipad
    //        if let popOver = optionMenu.popoverPresentationController {
    //            if let cell = tableView.cellForRow(at: indexPath){
    //                popOver.sourceView = cell
    //                popOver.sourceRect = cell.bounds
    //            }
    //        }
    //        present(optionMenu ,animated: true ,completion: nil)
    //    }
    
    // trailingSwipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        //delete
        let deleteAtcion = UIContextualAction(style: .destructive, title: "Delete") { action, sourceview, completionHandler in
            
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.restaurants.remove(at: indexPath.row)
            self.dataSource.apply(snapshot ,animatingDifferences: true)
            self.container?.mainContext.delete(restaurant)
            
            completionHandler(true)
        }
        //share
        let shareAction = UIContextualAction(style: .normal, title: "Share") { Action, sourceView, completionHandler in
            
            let defaultText = "Research for the restaurant"
            let activityController: UIActivityViewController
            
            activityController = UIActivityViewController(activityItems: [defaultText,
             restaurant.image], applicationActivities: nil)
            
            if let popOver = activityController.popoverPresentationController {
                
                let cell = tableView.cellForRow(at: indexPath)
                
                popOver.sourceView = cell
                popOver.sourceRect = cell!.bounds
            }
            self.present(activityController ,animated: true)
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
        
        let favorite = self.restaurants[indexPath.row].isFavorite
        let markAsFavorite = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHanedler in
            self.restaurants[indexPath.row].isFavorite = favorite ? false : true
            
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
