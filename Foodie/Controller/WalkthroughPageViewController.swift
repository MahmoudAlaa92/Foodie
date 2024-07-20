//
//  WalkthroughPageViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 19/07/2024.
//

import UIKit
protocol WalkthroughPageViewControllerDelegate: AnyObject{
    func didUpdatePageIndex(index: Int)
}

class WalkthroughPageViewController: UIPageViewController  {

    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?

    var pageHeadings = ["CREATE YOUR OWN FOOD GUIDE", "SHOW YOU THE LOCATION", "DISCOVER GREAT RESTAURANTS"]
    
    var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    
    var pageSubHeadings = ["Pin your favorite restaurants and create your ownfood guide","Search and locate your favourite restaurant on Maps","Find restaurants shared by your friends and other foodies"]
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        if let startPage = contentViewController(at: 0){
            setViewControllers([startPage], 
                               direction: .forward,
                               animated: true,
                               completion: nil ) }
    }
    
    func forwardPage() {
        currentIndex += 1
        
        if let nextVC = contentViewController(at: currentIndex) {
            setViewControllers([nextVC],
                               direction: .forward,
                               animated: true,
                               completion: nil ) }
    }
    
}

// MARK: - PageViewControllerDataSource

extension WalkthroughPageViewController: UIPageViewControllerDataSource{
    
    // Before
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    // After
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    // contentViewController
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
         
        if index < 0 || index >= pageHeadings.count{
            return nil
        }
        
        currentIndex = index
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
           
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController{
            pageContentViewController.index = index
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.imageFile = pageImages[index]
            return pageContentViewController
        }
        
        return nil
    }
}

// MARK: -

extension WalkthroughPageViewController: UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            
            if let contentVC = pageViewController.viewControllers?.first as? WalkthroughContentViewController{
                
                currentIndex = contentVC.index
                
                walkthroughDelegate?.didUpdatePageIndex(index: currentIndex)
            }
        }
    }
}
