//
//  SignUpViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 30/09/2024.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet weak var signUp: UIButton!{
        didSet{
            signUp.layer.cornerRadius = 15
            signUp.layer.masksToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        cutomizeNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Sign Up"
        nameTextField.becomeFirstResponder()
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

    @IBAction func signUpPressed(_ sender: UIButton) {
        guard let name = nameTextField.text ,name != "",
              let email = emailTextField.text ,email != "",
              let password = passwordTextField.text ,password != "" else{
            
            let alertController = UIAlertController(
                title: "Regesteration Error",
                message: "Please make sure you provide your name, email address and password to com plete the registration.",
                preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(okayAction)
            present(alertController ,animated: true)
            return
        }
        
        // Register the user account on Firebase
        Auth.auth().createUser(withEmail: email, password: password) {
            (user, error) in
            
            if let error = error{
                let alertController = UIAlertController(title: "Resgiteration Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel)
                alertController.addAction(okayAction)
                self.present(alertController ,animated: true)
                
            }
            
            // Save the name of the user
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                    if let error = error{
                        print("Failed to change the display name: \(error.localizedDescription)") }
                    
                }
            }
        }
        
      
        
    // Dismiss keyboard
        self.view.endEditing(true)
        
        
    // Send verification email
      Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
          print("Failed to send verification email")
      })
        
        let alertController = UIAlertController(title: "Email Verification", message: "We've just sent a confirmation email to your email address. Please check your inbox and click the verification link in that email to complete the sign up.", preferredStyle: .alert)
        
      let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                  // Dismiss the current view controller
                  self.dismiss(animated: true, completion: nil)
              })
        
      alertController.addAction(okayAction)
    self.present(alertController, animated: true)
      
        
        // Present the main view
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
            UIApplication.shared.keyWindow?.rootViewController = vc
            self.dismiss(animated: true)
        }
    }
}
