//
//  LoginViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 30/09/2024.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cutomizeNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Log In"
        emailField.becomeFirstResponder()
    }
    
    // Customize navigation bar
    func cutomizeNavigationBar(){
        
        if let appearance = navigationController?.navigationBar.standardAppearance {
            // Make the navigation bar transparent
            appearance.backgroundColor = UIColor(red: 239, green: 225, blue: 209)

            
            appearance.shadowColor = .clear
            // Customize title text attributes
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0, green: 0, blue: 0)]
                appearance.largeTitleTextAttributes = [
                    .foregroundColor: UIColor(red: 239, green: 225, blue: 209),
                    .font: customFont
                ]
            }
            
            // Apply the appearance to the navigation bar
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
    }
    
    // Login button
    @IBAction func loginPressed(_ sender: Any) {
        
        // validate the input
        guard let email = emailField.text ,email != "",
              let password = passwordField.text ,password != "" else{
            
            let alertController = UIAlertController(
                title: "Logine Error",
                message: "Bothe fields must not blanck",
                preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(okayAction)
            present(alertController ,animated: true)
            
            return
        }
        
            // perform login
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                let alertController = UIAlertController(
                    title: "Login Error",
                    message: "\(error.localizedDescription)",
                    preferredStyle: .alert)
                
                let okayAciton = UIAlertAction(title: "OK", style: .cancel)
                alertController.addAction(okayAciton)
                
                self.present(alertController ,animated: true)
                return
            }
            
            
            // Email Verification
//            guard let result = result ,result.user.isEmailVerified else{
//                let alertController = UIAlertController(
//                    title: "Login Error",
//                    message: "You haven't confirmed your email address yet. We sent you a confirmation email when you sign up. Please click the verification link in that email. If you need us to send the confirmation email again, please tap Resend Email.",
//                    preferredStyle: .alert)
//                
//                let okayAction = UIAlertAction(title: "Resend Email", style: .default) { action in
//                    Auth.auth().currentUser?.sendEmailVerification(completion: nil)
//                }
//                
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//                
//                alertController.addAction(okayAction)
//                alertController.addAction(cancelAction)
//                self.present(alertController ,animated: true)
//                
//                return
//            }
            
            // Dismiss the keyboard
            self.view.endEditing(true)
            
            
            // present the main view
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView"){
                UIApplication.shared.keyWindow?.rootViewController = vc
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
    }
}
