//
//  AddDetailsViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/13/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit
import CoreData

class AddDetailsViewController: UIViewController, UITextFieldDelegate {

  var categoryIndex: Int = -1
  var category: String = ""
  var segueToReturn: String = ""
  var action: String = ""
  var reminder: Reminders!
  var dataController = DataController()
  
  @IBOutlet weak var descriptionLabel: UITextField!
  @IBOutlet weak var expirationDateLabel: UITextField!
  @IBOutlet weak var alertMeSwitch: UISwitch!
  @IBOutlet weak var expirationDatePicker: UIDatePicker!
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    if action == "Edit" {
    
      self.title = "Edit Details"
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "editButton_TouchUpInside")
      
      
      self.descriptionLabel.text = reminder.reminder
      self.expirationDatePicker.date = reminder.expiration!
      
      let alert = reminder.alert == 1 ? true : false
      self.alertMeSwitch.setOn(alert, animated: true)
    
    } else {
    
      // Set page title
      
      self.title = "Add Details"
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButton_TouchUpInside")
    
    }
    
    
    // Setting up date piker
    expirationDatePicker.addTarget(self, action: Selector("expirationDatePiker_Changed:"), forControlEvents: UIControlEvents.ValueChanged)
    
    // Dismiss keyboard if toucher anywhere else
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    
    // Dismiss keyboard on press return
    self.descriptionLabel.delegate = self;
    
  }
  
  
  override func viewWillAppear(animated: Bool) {
    

    
  }
  
  func editButton_TouchUpInside () {
  
    let reminder = self.descriptionLabel.text
    let expiration = self.expirationDatePicker.date
    let alert = self.alertMeSwitch.on
    let completed = false // connect IBOutlet
    let id = Int(self.reminder.id!)
    
    if self.dataController.edtReminder(id, alert: alert, expiration: expiration, reminder: reminder!, completed: completed) {
      self.performSegueWithIdentifier(Constants.Segues.FromAddDetailsToTabBar, sender: self)
    } else {
      // Show alert on error
    }
    
  }
  
  func saveButton_TouchUpInside () {
    
    let reminder = self.descriptionLabel.text
    let expiration = self.expirationDatePicker.date
    let alert = self.alertMeSwitch.on
    
    if self.dataController.addReminder(alert, category: self.categoryIndex, expiration: expiration, reminder: reminder!) {
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
