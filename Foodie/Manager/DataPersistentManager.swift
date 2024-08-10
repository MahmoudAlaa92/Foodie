//
//  DataPersistentManager.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 09/08/2024.
//

import UIKit
import CoreData

enum DataBase: Error{
    case failToSaveDate
    case succesToSaveDate
    case failToFetchData
}

class DataPersistentManager{
    
    static let shared = DataPersistentManager()
    
    func creatDate(with model: FavouriteRestaurant ,completion: @escaping (Result<Void ,Error>) -> Void){
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
    
    func fetchData (completion: @escaping (Result<[RestaurantItem] ,Error>) -> Void ){
        
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
}
