//
//  ElementsTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 22/08/2024.
//

import UIKit

class ElementsTableViewCell: UITableViewCell ,UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var price = [String]()
    var names = [String]()
    var photos = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setUpCell (title: String ,price: [String] ,names: [String],Photos: [UIImage]){
        self.titleLabel.text = title
        self.photos = Photos
        self.price = price
        self.names = names
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionOfTableViewCell", for: indexPath) as? ElementsCollectionViewCell else{
            print("Error in collection of product cell")
            return UICollectionViewCell()
        }
        cell.iamgeView.image = photos[indexPath.row]
        cell.nameLable.text = names[indexPath.row]
        cell.priceLable.text = price[indexPath.row]
        
        return cell
    }
    
    // Size for item at index path
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}
