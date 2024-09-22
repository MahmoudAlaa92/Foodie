//
//  sizeOfFoodTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 15/09/2024.
//

import UIKit

class sizeOfFoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var smallLabel: UIButton!{
        didSet{
            smallLabel.layer.cornerRadius = smallLabel.frame.size.height / 2
            smallLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var mediumLabel: UIButton!{
        didSet{
            mediumLabel.layer.cornerRadius = mediumLabel.frame.size.height / 2
            mediumLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var largeLabel: UIButton!{
        didSet{
            largeLabel.layer.cornerRadius = largeLabel.frame.size.height / 2
            largeLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var xLargeLabel: UIButton!{
        didSet{
            xLargeLabel.layer.cornerRadius = xLargeLabel.frame.size.height / 2
            xLargeLabel.clipsToBounds = true
        }
    }
    
    var isSmallButtonSelected = false
    var isMediumButtonSelected = false
    var isLargeButtonSelected = false
    var isXLargeButtonSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func smallButton(_ sender: UIButton) {
        
        if isSmallButtonSelected {
            smallLabel.backgroundColor = .clear
            smallLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
        }else{
            smallLabel.backgroundColor = UIColor(named: "ButtonColor")
            smallLabel.setTitleColor(.white, for: .normal)
            
            mediumLabel.backgroundColor = .clear
            largeLabel.backgroundColor = .clear
            xLargeLabel.backgroundColor = .clear
            mediumLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            largeLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            xLargeLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            
        }
        isSmallButtonSelected.toggle()
    }
    
    @IBAction func mediumButton(_ sender: UIButton) {
        if isMediumButtonSelected {
            mediumLabel.backgroundColor = .clear
            mediumLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
        }else{
            mediumLabel.backgroundColor = UIColor(named: "ButtonColor")
            mediumLabel.setTitleColor(.white, for: .normal)
            
            smallLabel.backgroundColor = .clear
            largeLabel.backgroundColor = .clear
            xLargeLabel.backgroundColor = .clear
            smallLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            largeLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            xLargeLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
        }
        isMediumButtonSelected.toggle()
    }
    
    @IBAction func largeButton(_ sender: UIButton) {
        if isLargeButtonSelected {
            largeLabel.backgroundColor = .clear
            largeLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
        }else{
            largeLabel.backgroundColor = UIColor(named: "ButtonColor")
            largeLabel.setTitleColor(.white, for: .normal)
            
            mediumLabel.backgroundColor = .clear
            smallLabel.backgroundColor = .clear
            xLargeLabel.backgroundColor = .clear
            smallLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            mediumLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            xLargeLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            
        }
        isLargeButtonSelected.toggle()
    }
    
    @IBAction func XlargeButton(_ sender: UIButton) {
        if isXLargeButtonSelected {
            xLargeLabel.backgroundColor = .clear
            xLargeLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
        }else{
            xLargeLabel.backgroundColor = UIColor(named: "ButtonColor")
            xLargeLabel.setTitleColor(.white, for: .normal)
            
            mediumLabel.backgroundColor = .clear
            largeLabel.backgroundColor = .clear
            smallLabel.backgroundColor = .clear
            mediumLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            largeLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
            smallLabel.setTitleColor(UIColor(named: "ButtonColor"), for: .normal)
        }
        isXLargeButtonSelected.toggle()
    }
    
}
