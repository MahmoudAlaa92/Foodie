//
//  SliderImagesTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 10/09/2024.
//

import UIKit
protocol SliderImagesTableViewCellDelegate{
    func didSelectedSliderImage(indexPath: IndexPath)
}
class SliderImagesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var delegateSliderImage: SliderImagesTableViewCellDelegate?
    
    var images = [UIImage?]()
    var currentIndex = 0
    var timer: Timer?
    
    // Collection view
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.layer.cornerRadius = 25
            collectionView.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        startTimer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    // Move images in slider
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextImage), userInfo: nil, repeats: true)
    }

    // Set up images
    func setUpImages(images: [UIImage?]){
        self.images = images
    }
    
    @objc func moveToNextImage(){
        if currentIndex < images.count - 1{
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        
        collectionView.scrollToItem(
            at: IndexPath(item: currentIndex,
                          section: 0), at: .centeredHorizontally, animated: true)
    }
    
    // Stop timer when the cell is no longer visible
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderimagesCollection", for: indexPath) as? sliderImageCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.imageCell.image = images[indexPath.row]
        return cell
    }
    
    // Size for item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // Minimum line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    // Did selected item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateSliderImage?.didSelectedSliderImage(indexPath: indexPath)
    }
    
}
