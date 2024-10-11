//
//  CartViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 25/09/2024.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var subTotalTitle: UILabel!{
        didSet{
            subTotalTitle.text = "Sub Total:"
        }
    }
    @IBOutlet weak var shipingTitle: UILabel!{
        didSet{
            shipingTitle.text = "Shiping:"
        }
    }
    @IBOutlet weak var totalTitle: UILabel!{
        didSet{
            totalTitle.text = "Total:"
        }
    }
    @IBOutlet weak var textField: UITextField!{
        didSet{
            textField.layer.cornerRadius = 10
            textField.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var subTotal: UILabel!{
        didSet{
            subTotal.text = ""
        }
    }
    
    @IBOutlet weak var shiping: UILabel!{
        didSet{
            shiping.text = ""
        }
    }
    @IBOutlet weak var total: UILabel!{
        didSet{
            total.text = ""
        }
    }
    
    @IBOutlet weak var checkoutButton: UIButton!{
        didSet{
            checkoutButton.layer.cornerRadius = 15
            checkoutButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var addButton: UIButton!{
        didSet{
            addButton.layer.cornerRadius = 15
            addButton.layer.masksToBounds = true
        }
    }
    
    var cartItems = [CartItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        
        // Register
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cartCell")
        
        
        // Customize navigation bar
        customizeNavigationBar()
    }
    
    // View will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Cart "
        navigationController?.hidesBarsOnSwipe = true
        
        NotificationCenter.default.addObserver(forName: Notification.Name("cartItems"), object: nil, queue: nil) { _ in
            self.fetchCartItems()
        }
    }
    
    // Fetch cart items
    func fetchCartItems(){
        DataPersistentManager.shared.fetchCartItem { [weak self] result in
            
            switch result {
            case .success(let cartItems):
                DispatchQueue.main.async { [weak self] in
                    self?.cartItems = cartItems
                    self?.tableView.reloadData()
                    
                    // Update Cart Totals
                    self?.updateCartTotals(promoCode: false)
                }
            case .failure(let error):
                print("Error when retrive data: \(error)")
            }
        }
    }
    
    // Customize navigation bar
    func customizeNavigationBar(){
            
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 35.0) {
                appearance.titleTextAttributes = [.foregroundColor:UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")! ,.font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    @IBAction func addPromoCode(_ sender: UIButton) {
        updateCartTotals(promoCode: true)
    }
    
    @IBAction func checkoutPressed(_ sender: UIButton) {
        
    }
    
}

// MARK: - UITable View Delegate

extension CartViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count > 0 ?  cartItems.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegateOfQuantity = self
        cell.rowOfTableView = indexPath
        cell.nameLabel.text = cartItems[indexPath.row].name
        cell.priceLabel.text = "\(cartItems[indexPath.row].price)"
        cell.quantityLabel.text = "\(cartItems[indexPath.row].quantity)"
        if let imageView = cartItems[indexPath.row].image,let image = UIImage(data: imageView) {
            cell.img.image = image
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    // Update Cart Totals
    func updateCartTotals(promoCode: Bool){
        
        var subtotal = cartItems.reduce(0) { $0 + (Double($1.price) * Double($1.quantity)) }
        
        if promoCode && textField.text != ""{
            subtotal -= 20
            textField.text = ""
        }
        
        self.subTotal.text = String(format: "$%.2f", Double(subtotal))
        
        let shipingCost: Double = 30.0
        self.shiping.text = String(format: "$%.2f", Double(shipingCost))
        let totalCost = subtotal + shipingCost
        
        self.total.text = String(format: "$%.2f", totalCost)
        
    }
}

// MARK: - Increase or decrease item

extension CartViewController: CartTableViewCellDelegate{

    func didUpdateQuantity(indexPath: IndexPath, quantity: Int) {
        cartItems[indexPath.row].quantity = Int16(quantity)
        updateCartTotals(promoCode: false)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func deleteCartItem(indexPath: IndexPath) {
        let model = cartItems[indexPath.row]
        DataPersistentManager.shared.deleteCartItem(model) { result in
            switch result {
            case .success(()):
                print("Succesfully deleted")
                self.cartItems.remove(at: indexPath.row)
                self.fetchCartItems()
            case .failure(let error):
                print("Error when delete cart item from DB: \(error.localizedDescription)")
            }
        }
    }
}
