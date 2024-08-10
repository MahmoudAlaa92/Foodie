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
    }

    func fetchFavouriteRestaurantData(){
        DataPersistentManager.shared.fetchData { [weak self] result in
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
            
            return cell
        }
        return dataSource
    }

}
