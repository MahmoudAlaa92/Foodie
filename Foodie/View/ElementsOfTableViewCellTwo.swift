//
//  ElementsOfTableViewCellTwo.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 23/08/2024.
//

import UIKit

class ElementsOfTableViewCellTwo: UITableViewCell ,UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = "New Offers"
        }
    }
    @IBOutlet weak var collectionViewCell2: UICollectionView!
    
    
    var images = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        collectionViewCell2.delegate = self
        collectionViewCell2.dataSource = self
        
    }
    
    // Set up cell
    func setUpCell(images: [UIImage]){
        self.images = images
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionOfTableviewCellTwo", for: indexPath) as? ElementsOfCollectionViewCellTwo else{
            print("Error when casting to ElementsOfCollectionViewCellTwo")
            return UICollectionViewCell()
        }
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}
