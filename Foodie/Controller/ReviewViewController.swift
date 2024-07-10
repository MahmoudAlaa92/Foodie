//
//  ReviewViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 09/07/2024.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backGroundImageView: UIImageView!{
        didSet{
            backGroundImageView.image = UIImage(named: restaurant.image)
        }
    }
    var restaurant = Restaurant()
    
    @IBOutlet var ragteButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backGroundImageView.addSubview(blurEffectView)
        
        let moveButtonToRight = CGAffineTransform.init(translationX: 600, y: 0)
        let moveUpTransform = CGAffineTransform.init(scaleX: 5, y: 5)
        let moveScalreTransform =  moveUpTransform.concatenating(moveButtonToRight)
        
        for rateButton in ragteButtons{
            rateButton.alpha = 0
            rateButton.transform = moveScalreTransform
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        UIView.animate(withDuration: 0.4, delay: 0.1){
            self.ragteButtons[0].alpha = 1.0
            self.ragteButtons[0].transform = .identity
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.15) {
            self.ragteButtons[1].alpha = 1.0
            self.ragteButtons[1].transform = .identity
        }
        UIView.animate(withDuration: 0.4, delay: 0.2) {
            self.ragteButtons[2].alpha = 1.0
            self.ragteButtons[2].transform = .identity
        }
        UIView.animate(withDuration: 0.4, delay: 0.25) {
            self.ragteButtons[3].alpha = 1.0
            self.ragteButtons[3].transform = .identity
        }
        UIView.animate(withDuration: 0.4, delay: 0.3) {
            self.ragteButtons[4].alpha = 1.0
            self.ragteButtons[4].transform = .identity
        }
        
    }
    
}
