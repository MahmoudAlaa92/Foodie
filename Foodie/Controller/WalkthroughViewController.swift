//
//  WalkthroughViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 19/07/2024.
//

import UIKit

class WalkthroughViewController: UIViewController  {
    
 

    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var nextBtn: UIButton!{
        didSet{
            nextBtn.layer.cornerRadius = 15
            nextBtn.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var skipBtn: UIButton!
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // prepare Segue to walkthroughPageViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination
        
        if let destinationVC = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = destinationVC
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
    
    @IBAction func nextActionBtn(_ sender: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex{
            switch index{
            case 0...1:
                walkthroughPageViewController?.forwardPage()
            case 2: 
                UserDefaults.standard.set(true, forKey: "getStartedBtnPressed")
                dismiss(animated: true)
                
            default:
                break
            }
        }
        updateUI()
    }
    
    //updateUI
    func updateUI(){
        if let index = walkthroughPageViewController?.currentIndex{
            switch index{
            case 0...1:
                nextBtn.setTitle(String(localized: "NEXT"), for: .normal)
            case 2:
                nextBtn.setTitle(String(localized: "Get Started"), for: .normal)
            default:
                break
            }
            pageController.currentPage = index
        }
    }
    
    @IBAction func skiptActionBtn (sender: UIButton ){
        UserDefaults.standard.set(true, forKey: String(localized: "getStartedBtnPressed"))
        dismiss(animated: true)
    }
    
}

// MARK: - Walkthrough Page View Controller Delegate

extension WalkthroughViewController: WalkthroughPageViewControllerDelegate{
   
    func didUpdatePageIndex(index: Int) {
      updateUI()
    }
    
}

