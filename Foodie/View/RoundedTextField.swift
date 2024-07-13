//
//  RoundedTextField.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 13/07/2024.
//

import UIKit

class RoundedTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray6.cgColor
        self.layer.masksToBounds = true
        
    }
    
}
