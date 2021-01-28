//
//  OnboardingPagevVewVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 18/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class OnboardingPagevVewVC: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC( viewcontroller:"Onboarding1VC"),
                self.newVC(viewcontroller:"onboarding2VC")]
               
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setupPageControl()
        //adding dots to view controller
//        _ = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
        }

       
    }
    private func newVC(viewcontroller: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: viewcontroller)
    }
    

   

}

extension OnboardingPagevVewVC: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
        
    }
    
//    private func setupPageControl() {
//        let appearance = UIPageControl.appearance()
//        appearance.pageIndicatorTintColor = UIColor.lightGray
//        appearance.currentPageIndicatorTintColor = UIColor.darkGray
//        appearance.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.25)
//    }
//
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        setupPageControl()
//        return orderedViewControllers.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
    
    
}
