//
//  CategoriesTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 10/09/2024.
//

import UIKit

protocol CategoriesTableViewCellDelegate{
    func didSelectedItem(at indexPath: IndexPath)
}

class CategoriesTableViewCell: UITableViewCell, UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var titleLabel: UILabel!
    var photos = [UIImage?]()
    var names = [String]()
    
    var categoriesDelegate: CategoriesTableViewCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // Set up cell
    func setUpCell(title: String, photos: [UIImage?]){
        self.titleLabel.text = title
        self.photos = photos
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"categoriesCollection", for: indexPath) as? CategoriesCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.imageCategories.image = photos[indexPath.row]
        cell.nameOfRestaurant.text = names[indexPath.row]
        return cell
    }
    
    // Size for item at
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 90)
    }
    
    // Minimum line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    // Selected Items
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoriesDelegate?.didSelectedItem(at: indexPath)
    }
}
