//
//  FavouriteTableTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 08/08/2024.
//

import UIKit

class FavouriteTableViewController: UITableViewController {

    enum Section{
        case all
    }
    
    lazy var dataSource = configerDataSource()
    var favouriteRestaurant: [RestaurantItem] = []

    override func viewDidLoad(){
        super.viewDidLoad()

        fetchFavouriteRestaurantData()
        tableView.dataSource = dataSource
        NotificationCenter.default.addObserver(forName: Notification.Name("FavouriteRestaurant"), object: nil, queue: nil) { _ in
            self.fetchFavouriteRestaurantData()
        }
      
    }

    // fetch Favourite Restaurant
    func fetchFavouriteRestaurantData(){
        DataPersistentManager.shared.fetchFavouriteRestaurants { [weak self] result in
            switch result{
            case .success(let FavouriteRestaurant):
                DispatchQueue.main.async { [weak self] in
                    self?.favouriteRestaurant = FavouriteRestaurant
                    
                    // Create a snapshot and populate the data
                    var snapshot = NSDiffableDataSourceSnapshot<Section ,RestaurantItem>()
                    snapshot.appendSections([.all])
                    snapshot.appendItems(self!.favouriteRestaurant, toSection: .all)
                    self?.dataSource.apply(snapshot, animatingDifferences: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    // delete Favourite Restaurant
    func deleteFavouriteRestaurant(name restaurant: RestaurantItem ,index indexPath: IndexPath)
    {
        DataPersistentManager.shared.deleteFavouriteRestaurant(with: restaurant) { result in
            switch result{
            case .success(()):
                print("Deleted")
                var snapshot = self.dataSource.snapshot()
                snapshot.deleteItems([restaurant])
                self.favouriteRestaurant.remove(at: indexPath.row)
                self.dataSource.apply(snapshot ,animatingDifferences: true)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source

    func configerDataSource() -> UITableViewDiffableDataSource<Section ,RestaurantItem>{
        let identifier = "favouriteCell"
        
        let dataSource = UITableViewDiffableDataSource<Section ,RestaurantItem>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavouriteTableViewCell else{
                return UITableViewCell()
            }
            
            if let photo = self.favouriteRestaurant[indexPath.row].image {
                cell.imageCell.image = UIImage(data: photo)
            }
            cell.nameLabel.text = self.favouriteRestaurant[indexPath.row].name
            cell.locationLabel.text = self.favouriteRestaurant[indexPath.row].location
            cell.typeLabel.text = self.favouriteRestaurant[indexPath.row].type
            cell.selectionStyle = .none
            
            return cell
        }
        return dataSource
    }
    
    // trailingSwipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        //delete
        let deleteAtcion = UIContextualAction(style: .destructive, title: String(localized: "Delete")) { action, sourceview, completionHandler in
            
            self.deleteFavouriteRestaurant(name: restaurant, index: indexPath)
            completionHandler(true)
        }
        
        deleteAtcion.backgroundColor = UIColor.systemRed
        deleteAtcion.image = UIImage(systemName: "trash")
        
        let swipConfiguration = UISwipeActionsConfiguration(actions: [deleteAtcion ])
        return swipConfiguration
    }

}
