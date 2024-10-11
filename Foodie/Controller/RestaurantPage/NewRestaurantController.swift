//
//  NewRestaurantController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 13/07/2024.
//

import UIKit
import SwiftData

class NewRestaurantController: UITableViewController {

    var container: ModelContainer?
    var restaurant: Restaurant?
    
    var dataStore: RestaurantDataStore?
    
    @IBOutlet weak var photoImageView: UIImageView!{
        didSet{
            photoImageView.layer.cornerRadius = 10
            photoImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var nameTextField: RoundedTextField!{
        didSet{
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var typeTextField: RoundedTextField!{
        didSet{
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
   
        
    @IBOutlet weak var addressTextField: RoundedTextField!{
        didSet{
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    @IBOutlet weak var phoneTextField: RoundedTextField!{
        didSet{
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet{
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 10
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        container = try? ModelContainer(for: Restaurant.self)
        restaurant = Restaurant()
        
        // Customize navigationController
        if let apperance = navigationController?.navigationBar.standardAppearance{
            apperance.configureWithTransparentBackground()
            if  let customeFont = UIFont(name: "Nunito-Bold", size: 40){
                apperance.titleTextAttributes = [ .foregroundColor: UIColor(named: "NavigationBarTitle")! ]
                apperance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")! , .font: customeFont]
            }
            navigationController?.navigationBar.standardAppearance = apperance
            navigationController?.navigationBar.scrollEdgeAppearance = apperance
            navigationController?.navigationBar.compactAppearance = apperance
        }
      
        // layout
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        let margins = photoImageView.superview!.layoutMarginsGuide
        photoImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        // Hide Keyboard
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Table View
        tableView.backgroundColor = UIColor(named: "BackGound")
    }
    
    // View will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
        // Save Button
    @IBAction func saveNewRestaurant(_ sender: UIBarButtonItem) {
        guard let restaurant = restaurant else {
                return
            }

            // Update restaurant properties with the user inputs
            restaurant.name = nameTextField.text ?? ""
            restaurant.type = typeTextField.text ?? ""
            restaurant.location = addressTextField.text ?? ""
            restaurant.phone = phoneTextField.text ?? ""
            restaurant.summary = descriptionTextView.text
            restaurant.isFavorite = false
            
            // Assign the selected image to the restaurant
            if let image = photoImageView.image {
                restaurant.image = image
            }

            // Insert the restaurant into the SwiftData context
            container?.mainContext.insert(restaurant)

            // Try to save the context to persist the data
            do {
                try container?.mainContext.save()
                print("Restaurant saved successfully to the database.")
            } catch {
                print("Failed to save restaurant: \(error.localizedDescription)")
            }

            // Dismiss the current view and reload the data
            dismiss(animated: true) {
                self.dataStore?.fetchRestaurantData()
            }
    }
    
    // Check Text Fields Validate
    func checkTextFieldValidate(){
        if nameTextField.text == "" ||
           typeTextField.text == ""  ||
           addressTextField.text == "" ||
           phoneTextField.text == "" ||
           descriptionTextView.text == "" {
            let alert = UIAlertController(title: String(localized: "Oops"), message: String(localized: "We can't proceed because one of the fields is blank. Please note that all fields are required."), preferredStyle: .alert)
            let alertAction = UIAlertAction(title: String(localized: "OK"), style: .default, handler: nil)
            alert.addAction(alertAction)

            present(alert ,animated: true)
        }
        dismiss(animated: true)
    }
 
    //Selected Row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            
            let photoSource = UIAlertController(title: "", message: String(localized: "Choose your photo source"), preferredStyle: .actionSheet)
            
            let photoAction = UIAlertAction(title: String(localized: "Photo library"), style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker ,animated: true)
                }
            }
            let cameraAction = UIAlertAction(title: String(localized: "Camera"), style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .camera
                    imagePicker.allowsEditing = false
                    self.present(imagePicker ,animated: true)
                }
            }
            
            let cancelAction = UIAlertAction(title: String(localized: "Cancel"), style: .cancel)
            photoSource.addAction(photoAction)
            photoSource.addAction(cameraAction)
            photoSource.addAction(cancelAction)
           
            //for ipad
            if let popOver = photoSource.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popOver.sourceView = cell
                    popOver.sourceRect = cell.bounds
                }
            }
            present(photoSource ,animated: true)
                
        }
    }

}

//MARK: - TextFieldDelegate

extension NewRestaurantController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1){
            nextTextField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}

//MARK: - imagePackerDelegate

extension NewRestaurantController: UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true)
    }
    
}

