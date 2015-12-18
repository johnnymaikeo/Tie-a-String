//
//  JoinViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/8/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set page title
        
        self.title = "Join"
    }
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    
  }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        //self.navigationController?.navigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createButton_TouchUpInside(sender: AnyObject) {
      
      self.navigationController?.navigationBarHidden = true
      self.performSegueWithIdentifier(Constants.Segues.FromJoinToHome, sender: self)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
