//
//  LoginViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/8/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  override func viewDidLoad() {
    
    super.viewDidLoad()

    // Change back button text to Back
        
    let backItem = UIBarButtonItem()
    backItem.title = "Back"
    navigationItem.backBarButtonItem = backItem

  }

  override func didReceiveMemoryWarning() {
    
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
  }

}
