//
//  CartTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 25/09/2024.
//

import UIKit

protocol CartTableViewCellDelegate{
    func didUpdateQuantity(indexPath: IndexPath ,quantity: Int)
    func deleteCartItem(indexPath: IndexPath)
}

class CartTableViewCell: UITableViewCell {
 
    var delegateOfQuantity: CartTableViewCellDelegate?
    var rowOfTableView: IndexPath = IndexPath()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var count: Int = 1{
        didSet{
            quantityLabel.text = "\(count)"
        }
    }
    
    @IBOutlet weak var img: UIImageView!{
        didSet{
            img.layer.cornerRadius = 15
            img.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
    }
    

    @IBAction func plusButton(_ sender: UIButton) {
        if var quantity = Int(quantityLabel.text!){
            quantity += 1
            count = quantity
            delegateOfQuantity?.didUpdateQuantity(indexPath: rowOfTableView, quantity: count)
        }
    }
    
    
    @IBAction func minusButton(_ sender: UIButton) {
        if var quantity = Int(quantityLabel.text!) , quantity > 1{
            quantity -= 1
            count = quantity
            delegateOfQuantity?.didUpdateQuantity(indexPath: rowOfTableView, quantity: count)
        }
    }
    
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegateOfQuantity?.deleteCartItem(indexPath: rowOfTableView)
    }
    
}
