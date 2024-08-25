//
//  ElementsOfTableViewCellThree.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 23/08/2024.
//

import UIKit

class ElementsOfTableViewCellThree: UITableViewCell ,UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = "Favourite Brands"
        }
    }
    
    @IBOutlet weak var collectionViewCellThree: UICollectionView!
    
    var images = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewCellThree.delegate = self
        collectionViewCellThree.dataSource = self
        
    }

    // Set up cell
    func setUpCell(images: [UIImage]){
        self.images = images
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionOfCell3", for: indexPath) as? ElementsOfCollectionViewCellThree else{
            print("Error when casting to ElementsOfCollectionViewCellTwo")
            return UICollectionViewCell()
        }
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}
