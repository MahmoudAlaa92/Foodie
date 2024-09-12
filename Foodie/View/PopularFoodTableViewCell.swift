//
//  PopularFoodTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 12/09/2024.
//

import UIKit

class PopularFoodTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.layer.cornerRadius = 15
            collectionView.layer.masksToBounds = true
        }
    }
    
    var photos = [UIImage]()
    var name = [String]()
    var price = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "PopularFoodCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "popularFoodCollection")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}


// MARK: - collection View Delegate

extension PopularFoodTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularFoodCollection", for: indexPath) as? PopularFoodCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.nameLabel.text = name[indexPath.row]
        cell.priceLabel.text = price[indexPath.row]
        cell.imageOfLabel.image = photos[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
