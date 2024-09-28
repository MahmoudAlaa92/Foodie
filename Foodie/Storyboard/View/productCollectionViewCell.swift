//
//  productCollectionViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 12/09/2024.
//

import UIKit

protocol productCollectionViewCellDelegate: AnyObject{
    func didToggleFavorite(at indexPath: IndexPath,isFavorite: Bool)
}

class productCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: productCollectionViewCellDelegate?
    
    @IBOutlet weak var favouriteView: UIButton!
    
    var isFavourited = false {
        didSet{
            updateFavoriteButton()
            print(isFavourited)
        }
    }
    
    var row: Int? = nil
    var cellRow: Int? = nil
    
    
    @IBOutlet weak var insideView: UIView!{
        didSet{
            insideView.layer.cornerRadius = 15
            insideView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var productImage: UIImageView!{
        didSet{
            productImage.layer.cornerRadius = 15
            productImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateFavoriteButton()
    }
    
    @IBAction func favouriteBtn(_ sender: UIButton) {
        isFavourited.toggle()
        if let row = row ,let cellRow = cellRow{
            delegate?.didToggleFavorite(at: IndexPath(row: row, section: cellRow), isFavorite: isFavourited)
        }
    }
    
    @IBAction func cartBtn(_ sender: UIButton) {
    }
    
     func updateFavoriteButton() {
          let heartImage = isFavourited ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
          favouriteView.setImage(heartImage, for: .normal)
      }
    
}
