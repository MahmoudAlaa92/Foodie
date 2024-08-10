//
//  AboutTableTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 03/08/2024.
//

import UIKit
import SafariServices

class AboutTableTableViewController: UITableViewController {

    lazy var dataSource = configereDataSource()
    
    enum Section{
        case feedback
        case followus
    }
    
    struct LinkItem: Hashable{
        var text: String
        var link: String
        var image: String
    }
    
    var sectionContent = [ 
        [LinkItem(text: String(localized: "Twitter"), link: String(localized: "https://twitter.com/appcodamobile"), image: String(localized: "twitter")), LinkItem(text: String(localized: "Facebook"), link: String(localized: "https://facebook.com/appcodamobile"), image: String(localized: "facebook")), LinkItem(text: String(localized: "Instagram"), link: String(localized: "https://www.instagram.com/appcodadotcom"), image: String(localized: "instagram"))] ,
        [LinkItem(text: String(localized: "Rate us on App Store"), link: String(localized: "https://www.apple.com/ios/app-store/"), image: String(localized: "store")), LinkItem(text: String(localized: "Tell us your feedback"), link: String(localized: "http://www.appcoda.com/contact"), image: String(localized: "chat"))]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use large title for navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Customize the navigation bar appearance
        if let apperance = navigationController?.navigationBar.standardAppearance {
            apperance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0){
                apperance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                apperance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")! ,.font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = apperance
            navigationController?.navigationBar.scrollEdgeAppearance = apperance
            navigationController?.navigationBar.compactAppearance = apperance
        }
        
        // Load table data
        tableView.dataSource = dataSource
        updateSnapshot()
    }

    func updateSnapshot(){
        
        // Create a snapshot and populate the data
         var snapshot = NSDiffableDataSourceSnapshot<Section ,LinkItem>()
          snapshot.appendSections([.feedback ,.followus])
          snapshot.appendItems(sectionContent[0], toSection: .feedback)
          snapshot.appendItems(sectionContent[1], toSection: .followus)
        
        dataSource.apply(snapshot ,animatingDifferences: true)
    }
    
    // MARK: - Table view data source

    func configereDataSource() -> UITableViewDiffableDataSource<Section ,LinkItem>{
        
        let cellIdentifier = "aboutcell"
        
        let dataSource =  UITableViewDiffableDataSource<Section ,LinkItem>(tableView: tableView) { tableView, indexPath, linkItem in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            cell.textLabel?.text = linkItem.text
            cell.imageView?.image = UIImage(named: linkItem.image)
            
            return cell
        }
        
        return dataSource
    }
    
    // Selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.section{
        case 0:
            performSegue(withIdentifier: "showWebView", sender: self)
        case 1:
            openWithSafariViewController(indexPath: indexPath)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showWebView"{
            
            if let destinationVC = segue.destination as? WebViewController ,let indexPath = tableView.indexPathForSelectedRow ,let linkItem = self.dataSource.itemIdentifier(for: indexPath){
                destinationVC.targetUrl = linkItem.link
            }
        }
    }
    
    func openWithSafariViewController(indexPath: IndexPath){
        
        guard let linkedItem = self.dataSource.itemIdentifier(for: indexPath) else{
            return
        }
        
        if let url = URL(string: linkedItem.link){
            let safariController = SFSafariViewController(url: url)
            present(safariController ,animated: true)
        }
    }
    
}


