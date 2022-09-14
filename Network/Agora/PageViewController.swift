//
//  PageViewController.swift
//  Eithes
//
//  Created by Admin on 31/03/22.
//  Copyright © 2022 Iws. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
        
    lazy var orderedViewControlers : [UIViewController] = {
        return [self.newVC(viewController: "Onboarding1VC"),self.newVC(viewController: "onboarding2VC")]
    }()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerindex = orderedViewControlers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerindex - 1
        guard previousIndex >= 0 else{
            return orderedViewControlers.last
        }
        guard orderedViewControlers.count > previousIndex else {
            return nil
        }
        return orderedViewControlers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerindex = orderedViewControlers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerindex + 1
        guard orderedViewControlers.count != nextIndex else {
            return orderedViewControlers.first
        }
        
        guard orderedViewControlers.count > nextIndex else {
            return nil
        }
        return orderedViewControlers[nextIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
      if  let firstViewContrller = orderedViewControlers.first {
            setViewControllers([firstViewContrller], direction: .forward, animated: true, completion: nil)
            
                   }
    }
    
    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
}
