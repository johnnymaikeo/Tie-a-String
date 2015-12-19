//
//  JoinViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/8/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {
  @IBOutlet weak var nameTextBox: UITextField!
  @IBOutlet weak var emailTextBox: UITextField!
  @IBOutlet weak var passwordTextBox: UITextField!
  @IBOutlet weak var passwordValidationTextBox: UITextField!

  let dataController = DataController()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    // Set page title
        
    self.title = "Criar Conta"
    
  }
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    
  }
    
  override func viewWillDisappear(animated: Bool) {
        
    super.viewWillDisappear(animated)
        
  }

  override func didReceiveMemoryWarning() {
    
    super.didReceiveMemoryWarning()
  
  }
    
  @IBAction func createButton_TouchUpInside(sender: AnyObject) {
    
    // Validate form
    
    if validateForm() {
      
      // Add user to core data
      
      let name = self.nameTextBox.text
      let email = self.emailTextBox.text
      let password = self.passwordTextBox.text
      
      let id = self.dataController.addUser(name!, email: email!, password: password!)
      
      if id >= 0 {
    
        // Set user on NSDefaults
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setValue(true, forKey: "showWelcomeMessage");
        
        self.navigationController?.navigationBarHidden = true
        self.performSegueWithIdentifier(Constants.Segues.FromJoinToHome, sender: self)
        
      }
      
    }
        
  }

  internal func validateForm() -> Bool {
  
    if nameTextBox.text == "" {
    
      showFormValidationMessage("Por favor, preencher o campo nome do usuário!")
      return false
    
    }
    
    if emailTextBox.text == "" {
    
      showFormValidationMessage("Por favor, preencher o campo email!")
      return false
      
    } else {
    
      if !isValidEmail(emailTextBox.text!) {
      
        showFormValidationMessage("Formato do email inválido!")
        return false
      
      }
    
    }
    
    if passwordTextBox.text == "" {
    
      showFormValidationMessage("Por favor, preencher o campo senha")
    
    }
    
    if passwordValidationTextBox.text == "" {
    
      showFormValidationMessage("Por favor, repetir a senha no campo confirmação da senha")
    
    }
    
    if passwordTextBox.text != passwordValidationTextBox.text {
      
      showFormValidationMessage("Senha e confirmação de senha diferentes")
    
    }
  
    return true
    
  }
  
  internal func showFormValidationMessage(message: String) {
  
    let alertController = UIAlertController(title: Constants.Identifiers.AppName, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
    
    self.presentViewController(alertController, animated: true, completion: nil)
  
  }
  
  func isValidEmail(testStr:String) -> Bool {
    // println("validate calendar: \(testStr)")
    let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
  }
  
}
