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

    @IBOutlet var nameTextField: UITextField!{
        didSet{
            nameTextField.layer.cornerRadius = 10
            nameTextField.layer.masksToBounds = true
        }
    }
    @IBOutlet var emailTextField: UITextField!{
        didSet{
            emailTextField.layer.cornerRadius = 10
            emailTextField.layer.masksToBounds = true
        }
    }
    @IBOutlet var passwordTextField: UITextField!{
        didSet{
            passwordTextField.layer.cornerRadius = 10
            passwordTextField.layer.masksToBounds = true
            passwordTextField.isSecureTextEntry = true

        }
    }
    @IBOutlet weak var eyePassword: UIButton!{
        didSet{
            eyePassword.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    @IBOutlet weak var privacyCheck: UIButton!{
        didSet{
            privacyCheck.tintColor = .white
            privacyCheck.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
    }
    @IBOutlet weak var signUp: UIButton!{
        didSet{
            signUp.layer.cornerRadius = 15
            signUp.layer.masksToBounds = true
        }
    }
    
    var isPasswordVisible: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cutomizeNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Customise navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "NavigationBarTitle")
        
        self.title = "Sign Up"
        nameTextField.becomeFirstResponder()
    }
    
    // Customize navigation bar
    func cutomizeNavigationBar(){
        
        // Use large title for navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        if let apperance = navigationController?.navigationBar.standardAppearance {
            apperance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 35.0){
                apperance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                apperance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")! ,.font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = apperance
            navigationController?.navigationBar.scrollEdgeAppearance = apperance
            navigationController?.navigationBar.compactAppearance = apperance
        }
        
    }
    
    
    // Eye pressed
    // Eye Password Button
    @IBAction func eyePasswordPressed(_ sender: UIButton) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = isPasswordVisible
        
        let buttonImageName = isPasswordVisible ? "eye.slash.fill" : "eye.fill"
        eyePassword.setImage(UIImage(systemName: buttonImageName), for: .normal)
        
    }
    
    // Privacy policy
    @IBAction func privacyPolicy(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(systemName: "circle.fill"){
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            sender.tintColor = UIColor(named: "NavigationBarTitle")
        }else{
            sender.tintColor = .white
            sender.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
    }
    
    // Sign up
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
