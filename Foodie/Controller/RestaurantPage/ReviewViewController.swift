//
//  ReviewViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 09/07/2024.
//

import UIKit

class ReviewViewController: UIViewController {

    var restaurant = Restaurant()
    
    @IBOutlet weak var backGroundImageView: UIImageView!{
        didSet{
            backGroundImageView.image = restaurant.image
        }
    }
    
    @IBOutlet var rateButtons: [UIButton]!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backGroundImageView.addSubview(blurEffectView)
        
        let moveButttonFromTop = CGAffineTransform.init(translationX: 0, y: -500)
        
        for rateButton in rateButtons{
            closeButton.alpha = 0
            rateButton.alpha = 0
            closeButton.transform = moveButttonFromTop
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        UIView.animate(withDuration: 0.2 ,delay: 0.1) {
            self.closeButton.alpha = 1
            self.closeButton.transform = .identity
        }
        
        for index in 0..<rateButtons.count{
            UIView.animate(withDuration: 0.3, delay: 0.2) {
                self.rateButtons[index].alpha = 1.0
                self.rateButtons[index].transform = .identity
            }
        }

        
    }
    
}
