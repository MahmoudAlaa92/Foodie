//
//  AlertViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 26/09/2024.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var okLabel: UIButton!{
        didSet{
            okLabel.layer.cornerRadius = 20
            okLabel.layer.masksToBounds = true
        }
    }
    
    
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
    }
    
    func appear(sender: UIViewController){
        sender.present(self,animated: true){
            self.show()
        }
    }
    
    func show(){
        UIView.animate(withDuration: 0.1,delay: 0.0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 0.1, delay: 0.0 ,options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}
