//
//  RestaurantTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 24/06/2024.
//

import UIKit

class RestaurantTableViewController: UITableViewController  {
    
    lazy var dataSource = configureDataSource()
    
    var Restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phone: "348-233423", description: "A little gem hidden at the corner of the street is nothing but fantastic! This place is warm and cozy. We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of coffee drinks and specialties including lattes, cappuccinos, teas, and more. We serve breakfast, lunch, and dinner in an airy open setting. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "354-243523", description: "Take a moment to stop and smell tealeaves! We are about the community, our environment, and all things created by the warmth of our hands. We open at 11 AM, and close at 7 PM. At teakha, we sell only the best single-origin teas sourced by our sister company Plantation directly from small tea plantations. The teas are then either cooked to perfection with milk in a pot or brewed.", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "453-333423", description: "A great cafe in Austrian style. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. We also serve breakfast and light lunch. Come over to enjoy the elegant ambience and quality coffee.", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "983-284334", description: "An upscale dining venue, features premium and seasonal imported oysters, and delicate yet creative modern European cuisines. Its oyster bar displays a full array of freshest oysters imported from all over the world including France, Australia, USA and Japan.", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phone: "232-434222", description: "A great local cafe for breakfast and lunch! Located in a quiet area in Sheung Wan, we offer pork chop buns, HK french toast, and many more. We open from 7 AM to 4:30 PM.", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phone: "234-834322", description: "A boutique bakery focusing on artisan breads and pastries paired with inspiration from Japan and Scandinavia. We are crazy about bread and excited to share our artisan bakes with you. We open at 10 every morning, and close at 7 PM.", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phone: "982-434343", description: "We make everything by hand with the best possible ingredients, from organic sourdoughs to pastries and cakes. A combination of great produce, good strong coffee, artisanal skill and hard work creates the honest, soulful, delectable bites that have made Bourke Street Bakery famous. Visit us at one of our many Sydney locations!", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phone: "734-232323", description: "Haigh's Chocolates is Australia's oldest family owned chocolate maker. We have been making chocolate in Adelaide, South Australia since 1915 and we are committed to the art of premium chocolate making from the cocoa bean. Our chocolates are always presented to perfection in our own retail stores. Visit any one of them and you'll find chocolate tasting, gift wrapping and personalised attention are all part of the service.", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", phone: "872-734343", description: "We offer an assortment of on-site baked goods and sandwiches. This place has always been a favourite among office workers. We open at 7 every morning including Sunday, and close at 4 PM. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", phone: "343-233221", description: "The absolute best seafood place in town. The atmosphere here creates a very homey feeling. We open at 5 PM, and close at 10:30 PM.", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phone: "985-723623", description: "A young crowd populates this pork-focused American eatery in an older Williamsburg neighborhood. We open at 6PM, and close at 11 PM. If you enjoy a shared small plates dinner experience, come over and have a try.", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", phone: "455-232345", description: "Classic Italian deli & butcher draws patrons with meat-filled submarine sandwiches. We use the freshest meats and veggies to create the perfect panini for you. We look forward to seeing you!", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phone: "434-232322", description: "Small shop, some seating, definitely something different! We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of waffles with choices of sweet & savory fillings. If you are gluten free and craving waffles, this is the place to go.", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", phone: "343-234553", description: " Great food, cocktails, ambiance, service. Nothing beats having a warm dinner and a whiskey. We open at 8 every morning, and close at 1 AM. The ricotta pancakes are something you must try.", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phone: "342-455433", description: "Good place, great environment and amazing food! We open at 10 every morning except Sunday, and close at 9 PM. Give us a visit! Enjoy mushroom raviolis, pumpkin raviolis, meat raviolis with sausage and peppers, pork cutlets, eggplant parmesan, and salad.", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phone: "643-332323", description: "Most delicious cocktail you would ever try! Our menu includes a wide range of high quality internationally inspired dishes, vegetarian options, and local cuisine. We open at 10 AM, and close at 10 PM. We welcome you into our place to enjoy a meal with your friends.", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phone: "542-343434", description: "a collection of authentic Spanish Tapas bars in Central London! We have an open kitchen, a beautiful marble-topped bar where guests can sit and watch the chefs at work and stylish red leather stools. Lunch starts at 1 PM. Dinners starts 5:30 PM.", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phone: "722-232323", description: "Very good basque food, creative dishes with terrific flavors! Donostia is a high end tapas restaurant with a friendly relaxed ambiance. Come over to enjoy awesome tapas!", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phone: "343-988834", description: "Specialise in great pub food. Established in 1872, we have local and world lagers, craft beer and a selection of wine and spirits for people to enjoy. Don't forget to try our range of Young's Ales and Fish and Chips.", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phone: "432-344050", description: "With kitchen serving gourmet burgers. We offer food every day of the week, Monday through to Sunday. Join us every Sunday from 4:30 – 7:30pm for live acoustic music!", image: "cask", isFavorite: false)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        
        if let apperance = navigationController?.navigationBar.standardAppearance {
            apperance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 45){
                apperance.titleTextAttributes = [.foregroundColor : UIColor(named: "NavigationBarTitle")!
                ]
                apperance.largeTitleTextAttributes =  [.foregroundColor : UIColor(named: "NavigationBarTitle")!, .font:customFont
                ]
            }
            navigationController?.navigationBar.standardAppearance = apperance
            navigationController?.navigationBar.compactAppearance = apperance
            navigationController?.navigationBar.scrollEdgeAppearance = apperance
        }
        
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
//        tableView.rowHeight = UITableView.automaticDimension

        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(Restaurants ,toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Foodie"
        navigationController?.hidesBarsOnSwipe = true
    }
    // MARK: - UITableView Diffable Data Source
    
    func configureDataSource() -> RestaurantDiffableDataSource {
        
        let cellIdentifier = "datacell"
        
        let dataSource = RestaurantDiffableDataSource (
            tableView: tableView) { tableView, indexPath, restaurantName in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell else {
                    return UITableViewCell()
                }
                cell.nameLabel.text = self.Restaurants[indexPath.row].name
                cell.locationLabel.text = self.Restaurants[indexPath.row].location
                cell.typeLable.text = self.Restaurants[indexPath.row].type
                cell.imageCell.image = UIImage(named: self.Restaurants[indexPath.row].image)
                cell.favoriteImage.isHidden = self.Restaurants[indexPath.row].isFavorite ? false : true
                
                return cell
            }
        return dataSource
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
        dismiss(animated: true)
    }
    // MARK: - UITableViewDelegate Protocol
    
    //didSelectRow
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetails" {
            if let indexPath = tableView.indexPathForSelectedRow ,let destinationVC = segue.destination as? RestaurantDetailViewController {
                destinationVC.restaurant = Restaurants[indexPath.row]
            }
        }
    }
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        tableView.deselectRow(at: indexPath, animated: false)
    //
    //        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    //
    //        let reserve = { (action: UIAlertAction!) in
    //            let alert = UIAlertController(title: "sorry", message: "try in anoher time", preferredStyle: .alert)
    //            alert.addAction(UIAlertAction(title: "OK", style: .default))
    //            self.present(alert ,animated: true)
    //        }
    //
    //        let reserveAction = UIAlertAction(title: "resrveAction", style: .default, handler: reserve)
    //
    //        //Mark as a fovorite
    //        let favoriteAction = UIAlertAction(title: "Mark as a fovorite", style: .default) { (action: UIAlertAction!) in
    //            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
    //            self.Restaurants[indexPath.row].isFavorite = true
    //            cell.favoriteImage.image = UIImage(systemName: "heart.fill")
    //            cell.favoriteImage.isHidden = false
    //        }
    //        //Mark as unfovorite
    //        let unFavoriteAction = UIAlertAction(title: "Remove from favorite", style: .default){ (action: UIAlertAction!) in
    //            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
    //            self.Restaurants[indexPath.row].isFavorite = false
    //            cell.favoriteImage.isHidden = true
    //        }
    //
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    //
    //        optionMenu.addAction(reserveAction)
    //        optionMenu.addAction(favoriteAction)
    //        optionMenu.addAction(unFavoriteAction)
    //        optionMenu.addAction(cancelAction)
    //
    //        // for ipad
    //        if let popOver = optionMenu.popoverPresentationController {
    //            if let cell = tableView.cellForRow(at: indexPath){
    //                popOver.sourceView = cell
    //                popOver.sourceRect = cell.bounds
    //            }
    //        }
    //        present(optionMenu ,animated: true ,completion: nil)
    //    }
    
    // trailingSwipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        //delete
        let deleteAtcion = UIContextualAction(style: .destructive, title: "Delete") { action, sourceview, completionHandler in
            
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.Restaurants.remove(at: indexPath.row)
            self.dataSource.apply(snapshot ,animatingDifferences: true)
            
            completionHandler(true)
        }
        //share
        let shareAction = UIContextualAction(style: .normal, title: "Share") { Action, sourceView, completionHandler in
            
            let defualtActivity = "Research for the restaurant"
            let activityControler: UIActivityViewController
            
            if let imageToShare = UIImage(named: restaurant.image){
                activityControler = UIActivityViewController(activityItems: [defualtActivity ,imageToShare], applicationActivities: nil)
            } else {
                activityControler =  UIActivityViewController(activityItems: [defualtActivity], applicationActivities: nil)
            }
            
            if let popOver = activityControler.popoverPresentationController {
                
                let cell = tableView.cellForRow(at: indexPath)
                
                popOver.sourceView = cell
                popOver.sourceRect = cell!.bounds
            }
            self.present(activityControler ,animated: true)
            completionHandler(true)
        }
        
        deleteAtcion.backgroundColor = UIColor.systemRed
        deleteAtcion.image = UIImage(systemName: "trash")
        shareAction.backgroundColor = .systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipConfiguration = UISwipeActionsConfiguration(actions: [deleteAtcion ,shareAction])
        return swipConfiguration
    }
    
    //leadingSwipe
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = self.Restaurants[indexPath.row].isFavorite
        let markAsFavorite = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHanedler in
            self.Restaurants[indexPath.row].isFavorite = favorite ? false : true
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            if favorite {
                cell.favoriteImage.isHidden = true
            }else{
                cell.favoriteImage.image = UIImage(systemName: "heart.fill")
                cell.favoriteImage.isHidden = false
            }
            completionHanedler(true)
        }
        
        favorite ? (markAsFavorite.image = UIImage(systemName: "heart.slash.fill")) :
        (markAsFavorite.image = UIImage(systemName: "heart.fill"))
        
        markAsFavorite.backgroundColor = .systemYellow
        markAsFavorite.image?.withTintColor(.white)
        
        let swipConfigration = UISwipeActionsConfiguration(actions: [markAsFavorite])
        return swipConfigration
    }
    
}
