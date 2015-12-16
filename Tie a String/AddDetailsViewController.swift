//
//  AddDetailsViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/13/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class AddDetailsViewController: UIViewController, UITextFieldDelegate {

  var categoryIndex: Int = -1
  var category: String = ""
  var segueToReturn: String = ""
  
  @IBOutlet weak var descriptionLabel: UITextField!
  @IBOutlet weak var expirationDateLabel: UITextField!
  @IBOutlet weak var alertMeSwitch: UISwitch!
  @IBOutlet weak var expirationDatePicker: UIDatePicker!
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
        
    // Set page title
    self.title = "Add Details"
    
    
    // Setting up date piker
    expirationDatePicker.addTarget(self, action: Selector("expirationDatePiker_Changed:"), forControlEvents: UIControlEvents.ValueChanged)
    
    // Dismiss keyboard if toucher anywhere else
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    
    // Dismiss keyboard on press return
    self.descriptionLabel.delegate = self;
    
    if categoryIndex > -1 {
    
      
      
    }
    
  }
  
  
  override func viewWillAppear(animated: Bool) {
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButton_TouchUpInside");
    
  }
  
  
  func saveButton_TouchUpInside () {
    
    let reminder = Reminders()
    reminder.reminder = self.descriptionLabel.text
    reminder.expiration = self.expirationDatePicker.date
    reminder.alert = self.alertMeSwitch.on
    reminder.category = self.categoryIndex
    
    let dataController = DataController();
    
    if dataController.addReminder(reminder) {
      self.performSegueWithIdentifier(Constants.Segues.FromAddDetailsToTabBar, sender: self)
    } else {
      // Show alert on error
    }
    
  }
  
  func expirationDatePiker_Changed(datePicker:UIDatePicker) {
    let dateFormatter = NSDateFormatter()
    
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    
    let strDate = dateFormatter.stringFromDate(datePicker.date)
    expirationDateLabel.text = strDate
  }

  
  func dismissKeyboard() {
    
    view.endEditing(true)
    
  }
  
  // MARK: - description text field
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.view.endEditing(true)
    return false
    
  }
  
}
