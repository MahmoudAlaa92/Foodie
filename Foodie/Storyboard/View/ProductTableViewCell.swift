//
//  ProductTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 11/09/2024.
//

import UIKit

protocol ProductTableViewCellDelegate{
    func didselectedItem (at indexPath: IndexPath ,for tableViewRow: Int)
}

protocol isFavoriteChangedDelegate{
    func favoriteChanged (isFavorite: [Bool] ,row: Int ,value: Bool)
}

class ProductTableViewCell: UITableViewCell, productCollectionViewCellDelegate {

    var tableViewRow: Int?
    
    var selectedDelegate: ProductTableViewCellDelegate?
    var favoriteDelegate: isFavoriteChangedDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [UIImage] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var name = [String]()
    var price = [String]()
    var isFavorited: [Bool] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "productCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "productCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

// MARK: - UICollection View Delegate

extension ProductTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as? productCollectionViewCell else{
            print("Error in productCollectionViewCell")
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.productImage.image = photos[indexPath.row]
        cell.nameLabel.text = name[indexPath.row]
        cell.priceLabel.text = price[indexPath.row]
        cell.isFavourited = isFavorited[indexPath.row]
        cell.cellRow = tableViewRow
        cell.row = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: collectionView.frame.size.height)
    }
    //(UIScreen.main.bounds.width) * 0.43
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    // Did selected item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDelegate?.didselectedItem(at: indexPath ,for: tableViewRow ?? 0)
        
    }
    
    // Toggle Favorite
    func didToggleFavorite(at indexPath: IndexPath, isFavorite: Bool) {
        self.isFavorited[indexPath.row] = isFavorite
        saveFavoriteData(indexPath: indexPath ,isFavorite: isFavorite)
    }
    
    func saveFavoriteData(indexPath: IndexPath ,isFavorite: Bool){
        
        // User defaults
        let defaults = UserDefaults.standard
        if tableViewRow == 2 {
            let recommendedData = try? NSKeyedArchiver.archivedData(withRootObject: isFavorited, requiringSecureCoding: false)
            defaults.set(recommendedData, forKey: "favoriteBoolForRecommended")
            favoriteDelegate?.favoriteChanged(isFavorite: isFavorited, row: 2, value: isFavorite)
        }else if tableViewRow == 3{
            let bestSellerData = try? NSKeyedArchiver.archivedData(withRootObject: isFavorited, requiringSecureCoding: false)
            favoriteDelegate?.favoriteChanged(isFavorite: isFavorited, row: 3, value: isFavorite)
            defaults.set(bestSellerData, forKey: "favoriteBoolForBestSeller")
        }
        
        // save restaurant in DataBase (CoreData)
        if isFavorite {
            guard let imageData = photos[indexPath.row].jpegData(compressionQuality: 1.0) else { return }
            DataPersistentManager.shared.createFavouriteRestaurant(with: FavouriteRestaurant(
                image: imageData,
                name: name[indexPath.row],
                location: "Sheyakhah Oula, Aswan First, Aswan Governorate, Egypt",
                type: "Restaurant")) { result in
                    switch result{
                    case .success():
                        print("Restaurant Saved")
                        NotificationCenter.default.post(name: Notification.Name("FavouriteRestaurant"), object: nil)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }

}
