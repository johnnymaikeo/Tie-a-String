//
//  EnterViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/8/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController {
  
  @IBOutlet weak var nameTextBox: UITextField!
  @IBOutlet weak var passwordTextBox: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var messageLabel: UILabel!
  
  
  let dataController = DataController()

  override func viewDidLoad() {
  
    super.viewDidLoad()

    // Set page title
        
    self.title = "Entrar"
    
  }
    
  override func viewWillDisappear(animated: Bool) {
     
    super.viewWillDisappear(animated)
      
  }

  override func didReceiveMemoryWarning() {
  
    super.didReceiveMemoryWarning()
      
  }

  @IBAction func loginButton_TouchUpInside(sender: AnyObject) {
    
    if validateForm() {
    
      let user = dataController.fetchUser(nameTextBox.text!, password: passwordTextBox.text!)
      
      if user != nil {
        
        if user.name == nameTextBox.text && user.password == passwordTextBox.text {
        
          // Set last login data on core data
          _ = dataController.updateUserLoginData(user.name!)
          
          // Set user on NSDefaults
          let defaults = NSUserDefaults.standardUserDefaults();
          defaults.setValue(true, forKey: "showWelcomeMessage");
          
          self.navigationController?.navigationBarHidden = true
          self.performSegueWithIdentifier(Constants.Segues.FromEnterToHome, sender: self)
        
        } else {
        
          messageLabel.text = "Usuário ou senha incorretos"
        
        }
      
      } else {
      
        messageLabel.text = "Usuário ou senha incorretos"
      
      }
    
    }
        
  }
  
  internal func validateForm() -> Bool {
  
    if nameTextBox.text == "" || passwordTextBox.text == "" {
    
      messageLabel.text = "Preencha todos os campos para prosseguir"
      return false;
      
    }
    
    return true
  
  }
  
}
