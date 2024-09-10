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
                image: [UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")!]
               ),
        Product(title: "BestSeller",
                name: ["Siberia 800" ,"Siberia 800" ,"Siberia 800" ,"Siberia 800","Siberia 800","Siberia 800","Siberia 800"],
                price: ["L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000" ,"L.E65,000"],
                image: [UIImage(named: "Frame1")! ,UIImage(named: "Frame1")! ,UIImage(named: "Frame1")! ,UIImage(named: "Frame1")! ,UIImage(named: "Frame1")! ,UIImage(named: "Frame2")! ,UIImage(named: "Frame2")!]
               )
    ]
    
    var imagesCell2: [UIImage] = [
        UIImage(named: "Frame21")!,
        UIImage(named: "Frame21")!,
        UIImage(named: "Frame21")!,
        UIImage(named: "Frame21")!,
        UIImage(named: "Frame21")!,
        UIImage(named: "Frame21")!,
        UIImage(named: "Frame21")!,
        UIImage(named: "Frame21")!,
        UIImage(named: "Frame21")!
    ]
    
    var imagesCell3: [UIImage] = [
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!,
        UIImage(named: "FrameCell3")!
    ]

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        
    }
}

// MARK: - Table View Delegate

extension HomeViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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
        default:
            fatalError("Error in height for row at in home view controller")
        }
    }
    
}



