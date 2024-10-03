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
        updateUI()
        
        setupPageControl()

    }
    
    private func setupPageControl() {
          
          view.addSubview(pageController)
          
          // Disable autoresizing masks
          pageController.translatesAutoresizingMaskIntoConstraints = false
          
          // Set constraints
          NSLayoutConstraint.activate([
              pageController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
              pageController.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
              pageController.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
              pageController.heightAnchor.constraint(equalToConstant: 30) // Set height if necessary
          ])
      }
    
    
    func creatQuickAction(){
         
        // Add Quick Action
        if let bundleIdentifier = Bundle.main.bundleIdentifier{
            let shortcutItem1 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenRestaurants", localizedTitle: "Restaurnts", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "eyes"))
            let shortcutItem2 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenFavourites", localizedTitle: "Show Favorites", localizedSubtitle
           : nil, icon: UIApplicationShortcutIcon(systemImageName: "tag"), userInfo:
           nil)
            let shortcutItem3 = UIApplicationShortcutItem(type: "\(bundleIdentifier).NewRestaurant", localizedTitle: "New Restaurant", localizedSubtitle
           : nil, icon: UIApplicationShortcutIcon(type: .add), userInfo: nil)
            UIApplication.shared.shortcutItems = [shortcutItem1 ,shortcutItem2 ,shortcutItem3]
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        
        if let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomeView") as? UINavigationController {
            print("Yes")
            UIApplication.shared.keyWindow?.rootViewController = vc
            self.dismiss(animated: true)
            
        }
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
                creatQuickAction()
                
            default:
                break
            }
        }
        updateUI()
    }
    
    // Update UI
    func updateUI(){
        if let index = walkthroughPageViewController?.currentIndex{
            
            
            switch index{
            case 0:
                pageController.setIndicatorImage(UIImage(named: "current"), forPage: index)
                pageController.setIndicatorImage(UIImage(named: "dot"), forPage: 1)
                pageController.setIndicatorImage(UIImage(named: "dot"), forPage: 2)
            case 1:
                pageController.setIndicatorImage(UIImage(named: "dot"), forPage: 0)
                pageController.setIndicatorImage(UIImage(named: "current"), forPage: index)
                pageController.setIndicatorImage(UIImage(named: "dot"), forPage: 2)
            case 2:
                pageController.setIndicatorImage(UIImage(named: "dot"), forPage: 0)
                pageController.setIndicatorImage(UIImage(named: "dot"), forPage: 1)
                pageController.setIndicatorImage(UIImage(named: "current"), forPage: index)
            default:
                fatalError("Error in pageController")
            }
            
//            switch index{
//            case 0...1:
//                nextBtn.setTitle(String(localized: "NEXT"), for: .normal)
//            case 2:
//                nextBtn.setTitle(String(localized: "Get Started"), for: .normal)
//            default:
//                break
//            }
            pageController.currentPage = index
            
        }
    }
    
    @IBAction func skiptActionBtn (sender: UIButton ){
        UserDefaults.standard.set(true, forKey: String(localized: "getStartedBtnPressed"))
        dismiss(animated: true)
        creatQuickAction()
    }
    
}

// MARK: - Walkthrough Page View Controller Delegate

extension WalkthroughViewController: WalkthroughPageViewControllerDelegate{
   
    func didUpdatePageIndex(index: Int) {
      updateUI()
    }
    
}

