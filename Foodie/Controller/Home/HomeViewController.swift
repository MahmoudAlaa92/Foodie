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
    
    var categoriesImages = [
        Categories(title: "Categories", iamges: [
            UIImage(named: "cask"),
            UIImage(named: "cafelore"),
            UIImage(named: "cask"),
            UIImage(named: "fiveleaves"),
            UIImage(named: "cafedeadend"),
            UIImage(named: "haigh"),
            UIImage(named: "cafelore"),
            UIImage(named: "cask")
        ])
    ]
    
    var productsImages: [Product] = [
        Product(title: "Recomoneded",
                name: ["Mahmoud Siberia 800 MahmoudAlaa" ,"Siberia 800" ,"Siberia 800" ,"Siberia 800","Siberia 800","Siberia 800","Siberia 800"],
                price: ["L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000"],
                image: [UIImage(named: "koky")! ,UIImage(named: "koky")! ,UIImage(named: "koky")! ,UIImage(named: "koky")! ,UIImage(named: "koky")! ,UIImage(named: "koky")! ,UIImage(named: "koky")!]
               ),
        Product(title: "BestSeller",
                name: ["Siberia 800" ,"Siberia 800" ,"Siberia 800" ,"Siberia 800","Siberia 800","Siberia 800","Siberia 800"],
                price: ["L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000"],
                image: [UIImage(named: "burger1")! ,UIImage(named: "burger1")! ,UIImage(named: "burger1")! ,UIImage(named: "burger1")! ,UIImage(named: "burger1")! ,UIImage(named: "burger1")! ,UIImage(named: "burger1")!]
               )
    ]
    
    var newOffer = [NewOffer(descripion: "Enjoy your favorite food at discounted prices of up to 50%", image: UIImage(named: "NewOffer1"))]
    
    // Popular Food
    var pupularFood = Product(
        title: "Popular Food",
        name: ["Grilled chicken" ,"Vegetables pizza", "Meat pizzza", "Rice cake"],
    price: ["75L.E","55L.E" ,"95L.E" ,"45L.E"],
        image: [UIImage(named: "Popular1")!, UIImage(named: "Popular2")!, UIImage(named: "Popular3")!, UIImage(named: "Popular4")!] )
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        
        // Register the product nib file
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "productCell")
        
        //Registe the newOfferProduct nib file
        let nib2 = UINib(nibName: "NewOfferTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "newOfferCell")
        
        // Register the Popular Food nib file
        let nib3 = UINib(nibName: "PopularFoodTableViewCell", bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier: "PopularFoodCell")
    }
}

// MARK: - Table View Delegate

extension HomeViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sliderImagesCell", for: indexPath) as? SliderImagesTableViewCell else{
                return UITableViewCell()
            }
            
            cell.setUpImages(images: imagesOfSliderCollection)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as? CategoriesTableViewCell else{
                return UITableViewCell()
            }
            
            cell.setUpCell(title: categoriesImages[0].title, photos: categoriesImages[0].iamges)
            return cell
        case 2...3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell else{
                print("Error in product table view cell")
                return UITableViewCell()
            }
            
            let index = (indexPath.row == 2) ? 0 : 1
            cell.titleLabel.text = productsImages[index].title
            cell.photos = productsImages[index].image
            cell.name = productsImages[index].name
            cell.price = productsImages[index].price
            
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newOfferCell", for: indexPath) as? NewOfferTableViewCell else{
                print("Error in Offer table view cell")
                return UITableViewCell()
            }
            
            cell.titleOfCell.text = "New Offer"
            cell.descriptionLabel.text = newOffer[0].descripion
            cell.backgroundImage.image = newOffer[0].image
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularFoodCell", for: indexPath) as? PopularFoodTableViewCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = "Popular Food"
            cell.name = pupularFood.name
            cell.price = pupularFood.price
            cell.photos = pupularFood.image
            
            return cell
        default:
            fatalError("Error in when specific number of row in HomeViewContoller")
        }
    }
    
   // Hight table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 120
        case 2...3:
            return 200
        case 4...5:
            return 160
        default:
            fatalError("Error in height for row at in home view controller")
        }
    }
    
}



