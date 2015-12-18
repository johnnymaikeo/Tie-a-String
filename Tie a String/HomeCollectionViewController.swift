//
//  HomeCollectionViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/8/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {

  var tabToReturn: String!
  
  override func viewDidLoad() {
        
    super.viewDidLoad()
        
  }
    
    
  override func viewWillAppear(animated: Bool) {
    
    // show tab bar
      
    self.tabBarController?.tabBar.hidden = false
      
    // Hide back button from the home screen
    
    self.navigationItem.setHidesBackButton(true, animated: true)
      
    // Navigate
    if (tabToReturn != nil) {
      NSLog("segueToReturn: %@", self.tabToReturn)
    }
  }
    
}
