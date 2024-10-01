//
//  WelcomeViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 30/09/2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var signUp: UIButton!{
        didSet{
            signUp.layer.cornerRadius = 15
            signUp.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var signIn: UIButton!{
        didSet{
            signIn.layer.cornerRadius = 15
            signIn.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Welcome IN"
    }
    
    // Customize navigation bar
    func customizeNavigationBar(){
    
        // Use large title for navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 30){
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")! ,.font: customFont]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")! ,.font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        }
        navigationItem.backButtonTitle = ""
        navigationController?.hidesBarsOnSwipe = false
    }

    
}
