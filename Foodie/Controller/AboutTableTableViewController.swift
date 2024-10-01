//
//  AboutTableTableViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 03/08/2024.
//

import UIKit
import SafariServices
import Firebase
import FirebaseAuth

class AboutTableTableViewController: UITableViewController {

    @IBOutlet weak var profileImage: UIImageView!{
        didSet{
            profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
            profileImage.layer.masksToBounds = true
        }
    }
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
        [LinkItem(text: String(localized: "Rate us on App Store"), link: String(localized: "https://www.apple.com/ios/app-store/"), image: String(localized: "store")), LinkItem(text: String(localized: "Tell us your feedback"), link: String(localized: "http://www.appcoda.com/contact"), image: String(localized: "chat")),LinkItem(text: "Log Out", link: "", image: "logout")]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize the navigation bar appearance
        customizeNavigationBar()
        
        // Load table data
        tableView.dataSource = dataSource
        updateSnapshot()
    }

    
    // Customize navigation bar
    func customizeNavigationBar(){
        
        // Use large title for navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = true
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
    }
    
    // Update Snapshot
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
            if indexPath.row == 2{
                // Logout
                self.logout()
            }
            else{
                openWithSafariViewController(indexPath: indexPath) }
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // Logout
    func logout(){
       do{
           try Auth.auth().signOut()
       }catch{
           
           let alertController = UIAlertController(
               title: "LogOut Error",
               message: "\(error.localizedDescription)",
               preferredStyle: .alert)
           
           let okayAcrtin = UIAlertAction(title: "Ok", style: .cancel)
           alertController.addAction(okayAcrtin)
           
           present(alertController ,animated: true)
           return
       }
       
    // present Welcome View
        let welcomViewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeView")
       UIApplication.shared.keyWindow?.rootViewController = welcomViewVC
       
       self.dismiss(animated: true)
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


