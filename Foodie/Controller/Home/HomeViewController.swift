//
//  HomeViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 20/08/2024.
//

import UIKit

class HomeViewController: UIViewController {

    var imagesOfSliderCollection = [
        UIImage(named: "homei"),
        UIImage(named: "donostia"),
        UIImage(named: "bourkestreetbakery")
    ]
    
    @IBOutlet weak var pictureOfPerson: UIImageView!{
        didSet{
            pictureOfPerson.layer.cornerRadius = pictureOfPerson.frame.height / 2
            pictureOfPerson.clipsToBounds = true
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.layer.cornerRadius = 14
            searchBar.layer.masksToBounds = true
            searchBar.placeholder = "Search for restaurant"
            
        }
    }
    
    @IBOutlet weak var filterView: UIView!{
        didSet{
            filterView.layer.cornerRadius = 14
            filterView.layer.masksToBounds = true
            filterView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var sliderImageCollection: UICollectionView!
    var timer: Timer?
    var currentIndexCell = 0
    
    @IBOutlet weak var pageControllerOfSliderImages: UIPageControl!{
        didSet{
            pageControllerOfSliderImages.numberOfPages = imagesOfSliderCollection.count
        }
    }
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var categoriesImages = [
        UIImage(named: "cask"),
        UIImage(named: "cafelore"),
        UIImage(named: "cask"),
        UIImage(named: "fiveleaves"),
        UIImage(named: "cafedeadend"),
        UIImage(named: "haigh"),
        UIImage(named: "cafelore"),
        UIImage(named: "cask"),
    ]
    
    var productsImages: [Product] = [
        Product(title: "Recomoneded",
                name: ["Mahmoud Siberia 800 MahmoudAlaa" ,"Siberia 800" ,"Siberia 800" ,"Siberia 800","Siberia 800","Siberia 800","Siberia 800"],
                price: ["L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000"],
                image: [UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")!]
               ),
        Product(title: "BestSeller",
                name: ["Siberia 800" ,"Siberia 800" ,"Siberia 800" ,"Siberia 800","Siberia 800","Siberia 800","Siberia 800"],
                price: ["L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000"],
                image: [UIImage(named: "Frame1")! ,UIImage(named: "Frame1")! ,UIImage(named: "Frame1")! ,UIImage(named: "Frame1")! ,UIImage(named: "Frame1")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")!]
               )
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderImageCollection.delegate = self
        sliderImageCollection.dataSource = self
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self

        startTimer()
    }
    
  
    
    // slider Images view
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextSlider), userInfo: nil, repeats: true)
    }

   @objc func moveToNextSlider(){
        currentIndexCell += 1
        if currentIndexCell == imagesOfSliderCollection.count {
            currentIndexCell = 0
        }

       
       
       if let layout = sliderImageCollection.collectionViewLayout as? UICollectionViewFlowLayout {
           layout.scrollDirection = .horizontal
       }

       sliderImageCollection.scrollToItem(at: IndexPath(item: currentIndexCell, section: 0), at: .centeredHorizontally, animated: true)
       pageControllerOfSliderImages.currentPage = currentIndexCell
    }
   
}

// MARK: - Collection View Delegate

extension HomeViewController: UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case sliderImageCollection:
            return imagesOfSliderCollection.count
            
        case categoriesCollectionView:
            return categoriesImages.count
            
        default:
            fatalError("number Of Items InSection in Collection View ")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
            
            // Slider Image Collection
        case sliderImageCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderImageCell", for: indexPath) as? sliderImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageCell.image = imagesOfSliderCollection[indexPath.row]
            
            return cell
            
            // Categories Collection View
        case categoriesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as? CategoriesCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.imageCategories.image = categoriesImages[indexPath.row]
            
            return cell
            
        default:
            fatalError("Error in Collection View")
        }
    }
    
    // Size For Item At
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView{
        case sliderImageCollection:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
        case categoriesCollectionView:
            return CGSize(width: 70, height: 70)
        
        default:
            fatalError("Error in CGSize of collection view")
        }
    }
    
    // Minimum line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

// MARK: - Table View Delegate

extension HomeViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsImages.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as? ElementsTableViewCell else{
            return UITableViewCell()
        }
        
        cell.setUpCell(
            title: productsImages[indexPath.row].title,
            price: productsImages[indexPath.row].price,
            names: productsImages[indexPath.row].name,
            Photos: productsImages[indexPath.row].image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


