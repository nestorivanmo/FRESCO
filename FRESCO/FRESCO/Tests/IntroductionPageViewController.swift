//
//  IntroductionPageViewController.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 20/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class IntroductionPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    
    }
    
    private lazy var orderedViewControllers: [UIViewController] = {
        return [
            self.newColoredViewController(color: "Red"),
            self.newColoredViewController(color: "Green"),
            self.newColoredViewController(color: "Blue")
        ]
    }()
    
    private func newColoredViewController(color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "\(color)ViewController")
    }
    
}

extension IntroductionPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {return nil}
        var index = 0
        if viewControllerIndex - 1 == -1 {
            index = orderedViewControllers.count - 1
        } else {
            index = viewControllerIndex - 1
        }
        return orderedViewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {return nil}
        var index = 0
        if viewControllerIndex + 1 == orderedViewControllers.count {
            index = 0
        }else {
            index = viewControllerIndex + 1
        }
        return orderedViewControllers[index]
    }
    
}
