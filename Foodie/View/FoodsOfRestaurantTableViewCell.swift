//
//  FoodsOfRestaurantTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 14/09/2024.
//

import UIKit

protocol FoodsOfRestaurantTableViewCellDelegate{
    func didSelected(indexPath: IndexPath)
}

class FoodsOfRestaurantTableViewCell: UITableViewCell {
    
    var delegateOfSelectedItem: FoodsOfRestaurantTableViewCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos = [UIImage]()
    var namesOfRestaurant = [String]()
    var pricesOfRestaurant = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        // Register nib of product collection
        let nib = UINib(nibName: "productCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "productCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension FoodsOfRestaurantTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as? productCollectionViewCell else{
            print("productCollectionViewCell")
            return UICollectionViewCell()
        }
        
        cell.productImage.image = photos[indexPath.row]
        cell.nameLabel.text = namesOfRestaurant[indexPath.row]
        cell.priceLabel.text = pricesOfRestaurant[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 10, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // Did selected item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateOfSelectedItem?.didSelected(indexPath: indexPath)
    }
    
}
