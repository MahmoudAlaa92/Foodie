//
//  NavigationController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 04/07/2024.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
