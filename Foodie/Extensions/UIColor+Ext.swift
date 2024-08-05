//
//  UIColor+Ext.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 04/07/2024.
//

import UIKit

extension UIColor{
    convenience init(red: Int ,green: Int ,blue: Int){
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let yellowValue = CGFloat(blue) / 255.0
        self.init(red: redValue ,green: greenValue ,blue: yellowValue ,alpha: 1.0)
    }
}
