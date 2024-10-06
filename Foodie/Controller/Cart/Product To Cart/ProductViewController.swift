//
//  ProductViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 15/09/2024.
//

import UIKit

class ProductViewController: UIViewController {
    
    
    var nameOfFoodImage = "Pepperoni pizza"
    var imageofHeaderView =  UIImage()
    var isFavorite =  false
    var heartImage = UIImage()
    var priceOfFood = "L.E65,000"
    var descriptionOfFoodImage = "Highlights Button detailed trench coat has v-neck cuttingPocket detailed, two front patch pockets at the bottom Made with polyester blended material"
  
    @IBOutlet weak var headerView: HeaderOfProductToCartView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // Header view
        headerView.imageView.image = UIImage(named: nameOfFoodImage) ?? imageofHeaderView
        
        if isFavorite{
            headerView.favouriteBtn.setImage( UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            headerView.favouriteBtn.setImage( UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Customize navBar
        navigationController?.navigationBar.tintColor = UIColor(red: 82, green: 2, blue: 56)
    }

    @IBAction func plusBtn(_ sender: UIButton) {
       if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NameAndPriceOfRestaurantTableViewCell{
           cell.orderCount += 1
        }
    }
    @IBAction func minuseBtn(_ sender: UIButton) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NameAndPriceOfRestaurantTableViewCell{
            if cell.orderCount > 1 {
                cell.orderCount -= 1
            }
        }
    }
    // Add to cart
    @IBAction func addToCart(_ sender: UIButton) {
        
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NameAndPriceOfRestaurantTableViewCell{
            
            let filterPrice = priceOfFood.filter{ "0123456789".contains($0) }
            guard let imageData = headerView.imageView.image!.jpegData(compressionQuality: 1.0) else{
                print("Error when conver image to Data" )
                return
            }
            let model =
            Cart(image: imageData,
                 name: nameOfFoodImage,
                 price:Int64(filterPrice)!,
                 Quantity: Int16(cell.orderCount))
            
            DataPersistentManager.shared.createCartItem(model) { result in
                switch result{
                case .success(()):
                    
                    let alert = AlertViewController()
                    alert.messageOfLabel = "Added To Cart"
                    alert.imageName = "bag"
                    alert.appear(sender: self)
                    print("Saved")
                    
                    NotificationCenter.default.post(name: Notification.Name("cartItems"), object: nil)
                    
                case .failure(let error):
                    print("Error when save item: \(error)")
                }
            }
            
        }
        
    }
}

// MARK: - UITable View Delegate

extension ProductViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "nameOfEat", for: indexPath) as? NameAndPriceOfRestaurantTableViewCell else{
                return UITableViewCell()
            }
            cell.foodName.text = nameOfFoodImage
            cell.foodePrice.text = priceOfFood
            return cell   
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "size", for: indexPath) as? sizeOfFoodTableViewCell else{
                return UITableViewCell()
            }
            return cell        
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Highlights", for: indexPath) as? HighlightsTableViewCell else{
                return UITableViewCell()
            }
            
            cell.descriptionOfFood.text = descriptionOfFoodImage
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addToCart", for: indexPath) as? AddToCartTableViewCell else{
                return UITableViewCell()
            }
            
            return cell
            
        default:
            fatalError("Error in cell of table view of productViewController")
        }
    }
    
    // Height table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return  80 // name and price
        case 1:
            return  70 // size
        case 2:
            return 120  // Highlights
        case 3:
            return 70 // Button
       
        default:
            fatalError("Error in height of Product view controller")
        }
    }
}
