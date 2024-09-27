//
//  AlertViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 26/09/2024.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okLabel: UIButton!{
        didSet{
            okLabel.layer.cornerRadius = 20
            okLabel.layer.masksToBounds = true
        }
    }
    
    var imageName = ""
    var messageOfLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configerView()
    }
    
    init(){
        super.init(nibName: "AlertViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        hide()
    }
    
    
    func configerView(){
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.messageLabel.text = messageOfLabel
        self.image.image = UIImage(named: imageName)
    }
    
    func appear(sender: UIViewController){
        sender.present(self,animated: true){
            self.show()
        }
    }
    
    func show(){
            self.backView.alpha = 1
            self.contentView.alpha = 1
    }
    
    func hide(){
            self.backView.alpha = 0
            self.contentView.alpha = 0
            self.dismiss(animated: false)
            self.removeFromParent()
    }
}
