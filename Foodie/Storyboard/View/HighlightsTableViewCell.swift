//
//  HighlightsTableViewCell.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 15/09/2024.
//

import UIKit

class HighlightsTableViewCell: UITableViewCell {

//    @IBOutlet weak var descriptionOfFood: UITextView!
    @IBOutlet weak var descriptionOfFood: UILabel!{
        didSet{
            descriptionOfFood.numberOfLines = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
