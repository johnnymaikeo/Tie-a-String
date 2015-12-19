//
//  WelcomeViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/7/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var skipButton: UIButton!
    
    var pageViewController: UIPageViewController!
    var pageImages: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageImages = NSArray(objects: "img.JPG", "img.JPG", "img.JPG", "img.JPG", "img.JPG", "img.JPG")
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UniquePageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self;
        let startVC = self.viewControllerAtIndex(0) as PageContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.height - 100)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController {
        
        if ((self.pageImages.count == 0) || (index >= self.pageImages.count)) {
            return PageContentViewController();
        }
        
        let vc: PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        
        vc.imageFile = self.pageImages[index] as! String
        vc.pageIndex = index
        
        return vc
        
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController:
        UIViewController) -> UIViewController? {
    
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        setButtonText(index)
        index++
        
        if (index == self.pageImages.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    
        return self.pageImages.count
    
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    
        return 0
    
    }
    
    func setButtonText(index: Int) {
    
        // Change button from skip to start if last picture is hit

        if (index >= self.pageImages.count - 1) {
            self.skipButton.setTitle("Começar", forState: UIControlState.Normal)
        } else {
            self.skipButton.setTitle("Pular Introdução", forState: UIControlState.Normal)
        }
        
    }
    
    
}
