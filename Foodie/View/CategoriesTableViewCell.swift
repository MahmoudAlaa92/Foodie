//
//  CategoriesTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 10/09/2024.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell, UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var titleLabel: UILabel!
    var photos = [UIImage?]()
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.layer.cornerRadius = 20
            collectionView.clipsToBounds = true
            collectionView.layer.masksToBounds = true
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
        return cell
    }
    
    // Size for item at
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    // Minimum line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

}
