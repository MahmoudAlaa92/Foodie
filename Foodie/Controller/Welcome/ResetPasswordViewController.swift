//
//  ResetPasswordViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 30/09/2024.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!{
        didSet{
            emailField.layer.cornerRadius = 15
            emailField.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var sendButton: UIButton!{
        didSet{
            sendButton.layer.cornerRadius = 10
            sendButton.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeNavigationBar()
        emailField.becomeFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Forgot password"
        
        // Customise navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "NavigationBarTitle")
    }
    
    func customizeNavigationBar(){
        
        // Use large title for navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 35){
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")! ,.font: customFont]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")! ,.font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard let email = emailField.text ,email != "" else{
            
            let alertController = UIAlertController(
                title: "Input Errorr",
                message: "Please provide your email address for password reset",
                preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okayAction)
            
            present(alertController ,animated: true)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            
            let title = (error == nil) ? "Password Resset Follow-up" : "Password Resset Error"
            let message = (error == nil) ? "We have just sent a password resset email Please check your inbox follow the instructions to reset password" : error?.localizedDescription
            
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel) { action in
                
                if error == nil{
                    
                    self.view.endEditing(true)
                    
                    // return to login screen
                    if let navController = self.navigationController{
                        navController.popViewController(animated: true)
                    }
                }
            }
            
            alertController.addAction(okayAction)
            self.present(alertController ,animated: true)
            
        }
    }
    
}
