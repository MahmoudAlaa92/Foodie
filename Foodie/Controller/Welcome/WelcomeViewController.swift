//
//  WelcomeViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 30/09/2024.
//

import UIKit

class WelcomeViewController: UIViewController {

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

        
    }
    
    
}
