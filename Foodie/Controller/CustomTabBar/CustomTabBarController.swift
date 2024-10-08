//
//  CustomTabBarController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 08/10/2024.
//

import UIKit

class CustomTabBarController: UITabBarController {
    let tabbarView = UIView()
    var buttons: [UIButton] = []
    
    let tabbarItemBackgroundView = UIView()
    var centerConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Generate the view controllers
        generateControllers()
        
        // Add custom tab bar
        setView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the default UITabBar
        tabBar.isHidden = true
    }

    private func setView() {
        // Add custom tab bar view
        view.addSubview(tabbarView)
        tabbarView.backgroundColor = UIColor(named: "BackGound")
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        tabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tabbarView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        tabbarView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        tabbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tabbarView.layer.cornerRadius = 30
        tabbarView.layer.borderWidth = 1.0
        tabbarView.layer.borderColor = UIColor(named: "NotSelected")?.cgColor
        
        // Add background view for tab bar items
        tabbarView.addSubview(tabbarItemBackgroundView)
        tabbarItemBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        tabbarItemBackgroundView.widthAnchor.constraint(equalTo: tabbarView.widthAnchor, multiplier: 1/CGFloat(buttons.count), constant: -10).isActive = true
        tabbarItemBackgroundView.heightAnchor.constraint(equalTo: tabbarView.heightAnchor, constant: -10).isActive = true
        tabbarItemBackgroundView.centerYAnchor.constraint(equalTo: tabbarView.centerYAnchor).isActive = true
        tabbarItemBackgroundView.layer.cornerRadius = 25
        tabbarItemBackgroundView.backgroundColor = UIColor(named: "NavigationBarTitle")
        
        
        // Add tab bar buttons
        for x in 0..<buttons.count {
            tabbarView.addSubview(buttons[x])
            buttons[x].tag = x
            buttons[x].translatesAutoresizingMaskIntoConstraints = false
            buttons[x].centerYAnchor.constraint(equalTo: tabbarView.centerYAnchor).isActive = true
            buttons[x].widthAnchor.constraint(equalTo: tabbarView.widthAnchor, multiplier: 1/CGFloat(buttons.count)).isActive = true
            buttons[x].heightAnchor.constraint(equalTo: tabbarView.heightAnchor).isActive = true
            buttons[x].addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            // Manage button placement
            if x == 0 {
                buttons[x].leftAnchor.constraint(equalTo: tabbarView.leftAnchor).isActive = true
            } else {
                buttons[x].leftAnchor.constraint(equalTo: buttons[x - 1].rightAnchor).isActive = true
            }
        }
        
        // Initial active button center alignment
        centerConstraint = tabbarItemBackgroundView.centerXAnchor.constraint(equalTo: buttons[0].centerXAnchor)
        centerConstraint?.isActive = true
    }

    @objc private func buttonTapped(sender: UIButton) {
        selectedIndex = sender.tag
        
        for button in buttons {
            button.tintColor = UIColor(named: "NotSelected")
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .beginFromCurrentState) {
            self.centerConstraint?.isActive = false
            self.centerConstraint = self.tabbarItemBackgroundView.centerXAnchor.constraint(equalTo: self.buttons[sender.tag].centerXAnchor)
            self.centerConstraint?.isActive = true
            self.buttons[sender.tag].tintColor = .white
            self.tabbarView.layoutIfNeeded()
        }
    }

    private func generateControllers() {
        
        let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = homeStoryBoard.instantiateViewController(withIdentifier: "HomeView") as! UINavigationController
        
        let restaurantStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let restaurantVC = restaurantStoryBoard.instantiateViewController(withIdentifier: "RestaurantsNavController") as! UINavigationController
        
        let favoriteStoryBoard = UIStoryboard(name: "Favourites", bundle: nil)
        let favoriteVC = favoriteStoryBoard.instantiateViewController(identifier: "Favorites") as! UINavigationController

        let cartStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = cartStoryBoard.instantiateViewController(withIdentifier: "CartNavController") as! UINavigationController
        
        let profileStoryBoard = UIStoryboard(name: "About", bundle: nil)
        let profileVC = profileStoryBoard.instantiateViewController(withIdentifier: "AboutNavController") as! UINavigationController
        
        
        
        let home = generateViewControllers(image: UIImage(named: "home")!, vc: homeVC)
        let restaurants = generateViewControllers(image: UIImage(systemName: "star")!, vc: restaurantVC)
        let favorite = generateViewControllers(image: UIImage(named: "wich list")!, vc: favoriteVC)
        let cart = generateViewControllers(image: UIImage(named: "cart")!, vc: cartVC)
        let profile = generateViewControllers(image: UIImage(named: "profile")!, vc: profileVC)
        
        viewControllers = [home, restaurants, favorite, cart, profile]
    }

    private func generateViewControllers(image: UIImage, vc: UIViewController) -> UIViewController {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        if image == UIImage(named: "home"){
            button.tintColor = .white
        }else{
            button.tintColor = UIColor(named: "NotSelected")
        }
        
        let resizedImage = image.resize(targetSize: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysTemplate)
        button.setImage(resizedImage, for: .normal)
        buttons.append(button)
        return vc
    }
}

// Extension for resizing images
extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
