//
//  WalkthroughContentViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 18/07/2024.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet weak var headingLabel: UILabel! {
        didSet{
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var subHeadingLabel: UILabel! {
        didSet{
            subHeadingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var contentImageView: UIImageView!
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
    }
}
