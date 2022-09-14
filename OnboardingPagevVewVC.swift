//
//  OnboardingPagevVewVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 18/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class OnboardingPagevVewVC: UIPageViewController, UIPageViewControllerDelegate {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC( viewcontroller:"Onboarding1VC"),
                self.newVC(viewcontroller:"onboarding2VC")]
               
    }()

    var pageController = UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //adding dots to view controller
      //  _ = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
            
        }
        self.delegate = self
        setupPageControl()

       
    }
    private func newVC(viewcontroller: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: viewcontroller)
    }
    
}

extension OnboardingPagevVewVC: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of:viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
           // return orderedViewControllers.last
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pagecontentController = pageViewController.viewControllers![0]
        self.pageController.currentPage = orderedViewControllers.firstIndex(of: pagecontentController)!
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of:viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
           // return orderedViewControllers.first
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
        
    }
    
    private func setupPageControl() {
        
        pageController = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 220, width: UIScreen.main.bounds.width, height: 50))
        pageController.numberOfPages = orderedViewControllers.count
        pageController.currentPage = 0
        pageController.tintColor = UIColor.white
        pageController.pageIndicatorTintColor = UIColor.lightGray
        pageController.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageController)
    }

//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//       // setupPageControl()
//        return orderedViewControllers.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
//
    
    
}
