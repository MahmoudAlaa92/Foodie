//
//  RestaurantTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 24/06/2024.
//

import UIKit
import SwiftData
import UserNotifications

protocol RestaurantDataStore{
    func fetchRestaurantData()
}

class RestaurantTableViewController: UITableViewController ,RestaurantDataStore {
    
    var searchController: UISearchController!
    
    lazy var dataSource = configureDataSource()
    
    var container: ModelContainer?
    var dataStore: RestaurantDataStore?
    
    var restaurants: [Restaurant] = []
    
    @IBOutlet var emptyRestaurantView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // searchController
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Restaurants..."
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(named: "NavigationBarTitle")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        container = try? ModelContainer(for: Restaurant.self)
        
        // Customize navigationController
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
        
        // Table view
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = restaurants.count > 0 ? true : false
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchController.searchBar
        
        fetchRestaurantData()
        
        // Call notification
        prepareNotification()
    }
    
    // MARK: - Use Notifications
    
    func prepareNotification(){
        
        if restaurants.count <= 0 { return }
        
        // Pick restaurant randomly
        let randomNumber = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNumber]
        
        // Create user notification
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recomendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location). Would you like to give it a try?"
        content.sound = UNNotificationSound.default
        content.userInfo = ["phone" :suggestedRestaurant.phone]
        
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("seggestedRestaurant.jpg")
        
        try? suggestedRestaurant.image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
        
        if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL){
            content.attachments = [restaurantImage]
        }
        
        let categoryIdentifer = "foodie.restaurantAction"
        
        let makeReservationAction = UNNotificationAction(
            identifier: "foodie.makeReservation",
            title: "Reserve a table",
            options: [.foreground])
        
        let cancelAction = UNNotificationAction(
            identifier: "foodie.cancel",
            title: "Later",
            options: [])
        
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, cancelAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = categoryIdentifer
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
        let request = UNNotificationRequest(identifier: "foodie.restaurantSuggestion", content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request ,withCompletionHandler: nil)
    }
    
    
    // MARK: - Swift Data
    
    // Fetch restaurantData from DB
    func fetchRestaurantData(){
        let descriptor = FetchDescriptor<Restaurant>()
        
        restaurants = (try? container?.mainContext.fetch(descriptor)) ?? []
        updateSnapshot()
    }
    
    // search controller Update
    func fetchRestaurantData(searchText: String){
        
        let descriptor: FetchDescriptor<Restaurant>
        
        if searchText.isEmpty{
            descriptor = FetchDescriptor<Restaurant>()
        }else{
            let predicate = #Predicate<Restaurant> { $0.name.localizedStandardContains(searchText) || $0.location.localizedStandardContains(searchText) }
            descriptor = FetchDescriptor(predicate: predicate)
        }
        
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
    
    // unwind segue
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
        dismiss(animated: true)
    }
    
    // MARK: - UITableViewDelegate Protocol
    
    // prepare showRestaurantDetails
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetails" {
            if let indexPath = tableView.indexPathForSelectedRow ,let destinationVC = segue.destination as? RestaurantDetailViewController {
                destinationVC.restaurant = restaurants[indexPath.row]
                destinationVC.hidesBottomBarWhenPushed = true
            }
        }
        else if segue.identifier == "addNewRestaurant" {
            if let navController = segue.destination as? UINavigationController ,
               let destinationVC = navController.topViewController as? NewRestaurantController{
                print("Added")
                destinationVC.dataStore = self
            }
        }
        
    }
    
    // Context Menu Configuration
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else{
            return nil
        }
        
        let configeration = UIContextMenuConfiguration(
            identifier: indexPath.row as NSCopying,
            previewProvider: {
                
                guard let restaurantDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else {
                    return nil
                }
                restaurantDetailsVC.restaurant = restaurant
                return restaurantDetailsVC
                
            }) { action in
                
                let favouriteAction = UIAction(
                    title: "Save as favourite",
                    image: UIImage(systemName: "heart")){ action in
                    
                        let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                        self.restaurants[indexPath.row].isFavorite.toggle()
                        cell.favoriteImage.isHidden = !self.restaurants[indexPath.row].isFavorite
                }
                
                let shareAction = UIAction(
                    title: "Share",
                    image: UIImage(systemName: "square.and.arrow.up")) { action in
                    
                        let defaualtText = NSLocalizedString("Just checking in at ", comment: "Just checking in at ") + self.restaurants[indexPath.row].name
                        let activityController = UIActivityViewController(
                            activityItems: [defaualtText ,restaurant.image],
                            applicationActivities: nil)
                        self.present(activityController ,animated: true)
                }
                
                let deleteAction = UIAction(
                    title: "Delete",
                    image: UIImage(systemName: "trash")) { action in
                        var snapshot = self.dataSource.snapshot()
                        snapshot.deleteItems([restaurant])
                        self.dataSource.apply(snapshot ,animatingDifferences: true)
                        
                        self.container?.mainContext.delete(restaurant)
                    }
                return UIMenu(
                    title: "" ,
                    children: [favouriteAction ,shareAction ,deleteAction])
            }
        
        return configeration
        
    }
    
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: any UIContextMenuInteractionCommitAnimating) {
        
        guard let selectedRow = configuration.identifier as? Int else {
            return
        }
        
        guard let restaurantDeailsVC = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else{
            return
        }
        
        restaurantDeailsVC.restaurant = self.restaurants[selectedRow]
        
        animator.preferredCommitStyle = .pop
        animator.addCompletion {
            self.show(restaurantDeailsVC, sender: self)
        }
    }
    // trailingSwipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if searchController.isActive { return UISwipeActionsConfiguration() }
        
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        //delete
        let deleteAtcion = UIContextualAction(style: .destructive, title: String(localized: "Delete")) { action, sourceview, completionHandler in
            
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.restaurants.remove(at: indexPath.row)
            self.dataSource.apply(snapshot ,animatingDifferences: true)
            self.container?.mainContext.delete(restaurant)
            
            completionHandler(true)
        }
        //share
        let shareAction = UIContextualAction(style: .normal, title: String(localized: "Share")) { Action, sourceView, completionHandler in
            
            let defaultText = String(localized: "Research for the restaurant")
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
        let restaurant = self.restaurants[indexPath.row]
        let markAsFavorite = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHanedler in
            self.restaurants[indexPath.row].isFavorite = favorite ? false : true
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            
            
            if favorite {
                cell.favoriteImage.isHidden = true
            }else{
                cell.favoriteImage.image = UIImage(systemName: "heart.fill")
                cell.favoriteImage.isHidden = false
                
                // Convert UIImage to Data
                guard let imageData = restaurant.image.jpegData(compressionQuality: 1.0) else{
                    print("Error when conver image to Data" )
                    return
                }
                
                // save restaurant in DataBase (CoreData)
                DataPersistentManager.shared.createFavouriteRestaurant(with: FavouriteRestaurant(
                    image: imageData,
                    name: restaurant.name,
                    location: restaurant.location,
                    type: restaurant.type)) { result in
                        switch result{
                        case .success():
                            print("Restaurant Saved")
                            NotificationCenter.default.post(name: Notification.Name("FavouriteRestaurant"), object: nil)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                
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

//MARK: - SearchResults

extension RestaurantTableViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else{
            return
        }
        fetchRestaurantData(searchText: searchText)
    }
    
}
