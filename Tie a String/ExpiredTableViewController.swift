//
//  ExpiredTableViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/13/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class ExpiredTableViewController: UITableViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButton_TouchUpInside");
        
    }
    
    func addButton_TouchUpInside () {
        
        self.performSegueWithIdentifier(Constants.Segues.FromExpiredToSelectCategory, sender: self)
        
    }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == Constants.Segues.FromExpiredToSelectCategory {
        
      let viewController = segue.destinationViewController as! SelectCategoryCollectionViewController
        
      viewController.segueToReturn = Constants.Segues.FromAddDetailsToExpired
      
    }
  }
    
}
