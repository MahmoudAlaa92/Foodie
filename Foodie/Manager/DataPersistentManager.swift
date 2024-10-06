//
//  DataPersistentManager.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 09/08/2024.
//

import UIKit
import CoreData
import FirebaseStorage
import FirebaseFirestore

enum DataBase: Error{
    case failToSaveDate
    case succesToSaveDate
    case failToFetchData
    case failToDeleteData
}

class DataPersistentManager{
    
    static let shared = DataPersistentManager()
    var userId = ""
    private let userNameKey = "userName"
    private let userImageURLKey = "userImageURL"
    
    var userName: String? {
        get{
            return UserDefaults.standard.string(forKey: userNameKey)
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: userNameKey)
        }
    }
    
    var userImageURL: URL?{
        get{
            if let urlString = UserDefaults.standard.string(forKey: userImageURLKey){
                return URL(string: urlString)
            }
            return nil
        }
        set{
            UserDefaults.standard.setValue(newValue?.absoluteString, forKey: userImageURLKey)
        }
    }
    
    // Create favourite restaurant
    func createFavouriteRestaurant(with model: FavouriteRestaurant ,completion: @escaping (Result<Void ,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let favouriteItemEntity = NSEntityDescription.entity(forEntityName: "RestaurantItem", in: managedContext) else{
            print("Error in NsEntityDescription")
            return
        }
        
        let itemToSave = NSManagedObject(entity: favouriteItemEntity, insertInto: managedContext)
        
        itemToSave.setValue(model.image, forKey: "image")
        itemToSave.setValue(model.location, forKey: "location")
        itemToSave.setValue(model.name, forKey: "name")
        itemToSave.setValue(model.type, forKey: "type")
        
        do{
            try managedContext.save()
            completion(.success(()))
        }catch{
            completion(.failure(DataBase.failToSaveDate))
        }
    }
    
    // Fetch favourite restaurant
    func fetchFavouriteRestaurants(completion: @escaping (Result<[RestaurantItem] ,Error>) -> Void ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<RestaurantItem>(entityName: "RestaurantItem")
        
        do{
            let restaurantItem = try managedContext.fetch(fetchRequest)
            completion(.success(restaurantItem))
        }catch{
            completion(.failure(DataBase.failToFetchData))
            print("Error When Fetch Data From DB")
        }
    }
    
    // Delete favourite restaurant
  func deleteFavouriteRestaurant(with model: RestaurantItem ,completion: @escaping (Result<Void ,Error>) -> Void){
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
      let managedContext = appDelegate.persistentContainer.viewContext
      
      managedContext.delete(model)
      do{
          try managedContext.save()
          completion(.success(()))
      }catch{
          completion(.failure(DataBase.failToDeleteData))
      }
      
    }
    
    // MARK: - Cart Methods
    
    // Create cart item

    func createCartItem(_ model: Cart ,completion: @escaping (Result<Void ,Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let cartItemEntity = NSEntityDescription.entity(forEntityName: "CartItem", in: managedContext) else {
            print("Error in NsEntityDescription")
            return
        }
        
        let itemToSave = NSManagedObject(entity: cartItemEntity, insertInto: managedContext)
        
        itemToSave.setValue(model.image, forKey: "image")
        itemToSave.setValue(model.name, forKey: "name")
        itemToSave.setValue(model.price, forKey: "price")
        itemToSave.setValue(model.Quantity, forKey: "quantity")
        
        do{
            try managedContext.save()
            completion(.success(()))
        }catch{
            
            completion(.failure(DataBase.failToSaveDate))
        }
    }
    
    
    // Fetch cart item
    func fetchCartItem(completion: @escaping (Result<[CartItem] ,Error>) -> Void ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CartItem>(entityName: "CartItem")
        
        do{
            let cartItems = try managedContext.fetch(fetchRequest)
            completion(.success(cartItems))
        }catch{
            completion(.failure(DataBase.failToFetchData))
            
        }
    }
    
    // Delete cart item
    func deleteCartItem(_ model: CartItem ,completion: @escaping (Result<Void ,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(model)
        
        do{
            try managedContext.save()
            completion(.success(()))
        }catch{
            completion(.failure(DataBase.failToDeleteData))
            
        }
    }
    
}

// MARK: - Firebase
extension DataPersistentManager{
    
    // Uploud image to firebase
    
    func uploadImage(image: UIImage, imageName: String, completion: @escaping (String?) -> Void) {
        let storageRef = Storage.storage().reference().child("Product_images/\(imageName).png")
        
        if let imageData = image.pngData() {
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard error == nil else {
                    print("Error uploading image: \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                // Retrieve download URL after successful upload
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("Error getting download URL: \(error!.localizedDescription)")
                        completion(nil)
                        return
                    }
                    completion(downloadURL.absoluteString) // Return the URL string
                }
            }
        } else {
            completion(nil)
        }
    }
    
    // Save to Firstore
    func saveToFirestore(restaurantData: [String: Product], imageUrls: [String],to folderName: String) {
        let db = Firestore.firestore()
        
        for (restaurantName, product) in restaurantData {
            // Create a dictionary to store in Firestore
            var productData: [String: Any] = [
                "title": product.title,
                "names": product.names,
                "prices": product.prices
            ]
            
            // Add the image URLs
            productData["imageUrls"] = imageUrls
            
            // Save to Firestore under the collection "restaurants"
            db.collection(folderName).document(restaurantName).setData(productData) { error in
                if let error = error {
                    print("Error saving restaurant data: \(error)")
                } else {
                    print("Restaurant data saved successfully!")
                }
            }
        }
    }
    
    func retrieveFromFirestore(for restaurantName: String, from folderName: String ,completion: @escaping (Product?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection(folderName).document(restaurantName)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()!
                let title = data["title"] as! String
                let names = data["names"] as! [String]
                let prices = data["prices"] as! [String]
                let imageUrls = data["imageUrls"] as! [String]
                
                // Download images from URLs
                var images = [UIImage]()
                let group = DispatchGroup()
                
                for url in imageUrls {
                    group.enter()
                    self.downloadImage(from: URL(string: url)!) { image in
                        if let img = image {
                            images.append(img)
                        }
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    let product = Product(title: title, names: names, prices: prices, images: images)
                    completion(product)
                }
            } else {
                print("Document does not exist for \(restaurantName)")
                completion(nil)
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(error?.localizedDescription ?? "No error info")")
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        task.resume()
    }
}
