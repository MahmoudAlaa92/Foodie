//
//  NewOfferTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 12/09/2024.
//

import UIKit

class NewOfferTableViewCell: UITableViewCell {

    @IBOutlet weak var titleOfCell: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!{
        didSet{
            backgroundImage.layer.cornerRadius = 17
            backgroundImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var getOfferBtn: UIButton!{
        didSet{
            getOfferBtn.layer.cornerRadius = 10
            getOfferBtn.layer.masksToBounds = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func getPressed(_ sender: UIButton) {
    }
    
}
