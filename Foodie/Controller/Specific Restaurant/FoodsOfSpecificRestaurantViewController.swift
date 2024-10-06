//
//  FoodsOfSpecificRestaurantViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 14/09/2024.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import JGProgressHUD

class FoodsOfSpecificRestaurantViewController: UIViewController {
    
    var selectedItem = ""
    
    var itemsOfRestaurant: [String : Product] = [
        :
    ]
    
    @IBOutlet weak var nameOfRestaurant: UILabel!
    
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var imageOfRestaurant: UIImageView!{
        didSet{
            imageOfRestaurant.layer.cornerRadius = imageOfRestaurant.frame.size.height / 2
            imageOfRestaurant.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //Selected item
        print(selectedItem)
        nameOfRestaurant.text = selectedItem
        imageOfRestaurant.image = UIImage(named: selectedItem) 
        
        // Register nib of product tableView
        let nib = UINib(nibName: "FoodsOfRestaurantTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "foodsOfRestaurantCell")

        // Retrieve data from firebase
        retrieveItemsOfRestaurant()
        
        
                // Uploud new items
//                let group = DispatchGroup()
//                var imageUrls = [String]()
//        
//                for (restaurantName, product) in itemsOfRestaurant {
//                    for (index, image) in product.images.enumerated() {
//                        group.enter()
//                        let imageName = "\(restaurantName)_\(product.names[index])"
//        
//                        // Upload image and get the download URL
//                        DataPersistentManager.shared.uploadImage(image: image, imageName: imageName) { url in
//                            if let imageUrl = url {
//                                imageUrls.append(imageUrl)  // Store the image URL
//                            }
//                            group.leave()
//                        }
//                    }
//                }
//                group.notify(queue: .main) { [self] in
//                    // Once all uploads are done, save the image URLs and restaurant data in Firestore
//                    DataPersistentManager.shared.saveToFirestore(restaurantData: itemsOfRestaurant, imageUrls: imageUrls, to: "restaurants")
//                }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Customise navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "NavigationBarTitle")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "BackGround")
    }
    
    // Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Retrieve Items Of Restaurant
    func retrieveItemsOfRestaurant(){
        
        let hud = JGProgressHUD()
        hud.textLabel.text = "Loading"
        hud.detailTextLabel.text = "Please wait"
        hud.show(in: view)
        
        //   Retrieve data from firebase
        DataPersistentManager.shared.retrieveFromFirestore(for: selectedItem, from: "restaurants") { [weak self] product in
            guard let self = self, let product = product else { return }
            
            // Update the itemsOfRestaurant dictionary
            self.itemsOfRestaurant[self.selectedItem] = product
            
            // Reload the tableView to show the data
            DispatchQueue.main.async {
                self.tableView.reloadData()
                hud.dismiss()
            }
            
        }
    }
    
}

// MARK: - UITable View Delegate

extension FoodsOfSpecificRestaurantViewController: UITableViewDelegate ,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsOfRestaurant[selectedItem]?.images.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "foodsOfRestaurantCell", for: indexPath) as? FoodsOfRestaurantTableViewCell else{
            print("Error in foodsOfRestaurantCell")
            return UITableViewCell()
        }
        
        cell.delegateOfSelectedItem = self
        cell.photos = itemsOfRestaurant["\(selectedItem)"]!.images
        cell.namesOfRestaurant = itemsOfRestaurant["\(selectedItem)"]!.names
        cell.pricesOfRestaurant = itemsOfRestaurant["\(selectedItem)"]!.prices
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height - ((UIScreen.main.bounds.height * 0.138) * 2) - (navigationController?.navigationBar.frame.height ?? 50)
    }
}

// MARK: - Selected items in table view
extension FoodsOfSpecificRestaurantViewController: FoodsOfRestaurantTableViewCellDelegate{
    func didSelected(indexPath: IndexPath) {
        guard let destinationVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController else { return }
        
        destinationVC.nameOfFoodImage = (itemsOfRestaurant[selectedItem]?.names[indexPath.row])!
        destinationVC.priceOfFood = (itemsOfRestaurant[selectedItem]?.prices[indexPath.row])!
        destinationVC.imageofHeaderView = (itemsOfRestaurant[selectedItem]?.images[indexPath.row])!
        
        self.show(destinationVC, sender: self)
    }
}
