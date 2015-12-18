//
//  AddDetailsViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/13/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit
import CoreData

class AddDetailsViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  var categoryIndex: Int = -1
  var category: String = ""
  var segueToReturn: String!
  var action: String = ""
  var reminder: Reminders!
  var dataController = DataController()
  var imagePicker: UIImagePickerController!
  let imageController = ImageController()
  
  @IBOutlet weak var descriptionLabel: UITextField!
  @IBOutlet weak var expirationDateLabel: UITextField!
  @IBOutlet weak var alertMeSwitch: UISwitch!
  @IBOutlet weak var activeSwitch: UISwitch!
  @IBOutlet weak var expirationDatePicker: UIDatePicker!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var takePictureButton: UIButton!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    if action == "Edit" {
    
      self.title = "Edit Details"
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "editButton_TouchUpInside")
      
      
      self.descriptionLabel.text = reminder.reminder
      self.expirationDatePicker.date = reminder.expiration!
      
      let alert = reminder.alert?.boolValue
      let active = reminder.active?.boolValue
      self.alertMeSwitch.setOn(alert!, animated: true)
      self.activeSwitch.setOn(active!, animated: true)
      
      
      // Load image if exists

      let id = Int(reminder.id!)
      if let loadedImage = imageController.loadImageFromPath(self.imagePath(id)) {
        
        image.image = loadedImage
        
      } else {

        // Load a default image according to category
        
      }
    
    } else {
    
      // Set page title
      
      self.title = "Add Details"
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButton_TouchUpInside")
    
    }
    
    // Hide tab bar on creating/editing reminder
    self.tabBarController?.tabBar.hidden = true
    
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
    let id = Int(self.reminder.id!)
    let active = self.activeSwitch.on
    
    let result = self.dataController.edtReminder(id, alert: alert, expiration: expiration, reminder: reminder!, completed: active)
    
    if  result >= 0{
      
      savePicture(id)
      self.performSegueWithIdentifier(Constants.Segues.FromAddDetailsToTabBar, sender: self)
      
    } else {
      // Show alert on error
    }
    
  }
  
  func saveButton_TouchUpInside () {
    
    let reminder = self.descriptionLabel.text
    let expiration = self.expirationDatePicker.date
    let alert = self.alertMeSwitch.on
    let active = self.activeSwitch.on
    
    let result = self.dataController.addReminder(alert, category: self.categoryIndex, expiration: expiration, reminder: reminder!, active: active)
    
    if result >= 0 {
      
      savePicture(result)
      self.performSegueWithIdentifier(Constants.Segues.FromAddDetailsToTabBar, sender: self)
      
    } else {
      // Show alert on error
    }
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // Hide back button
    
    self.navigationItem.setHidesBackButton(true, animated:true)
    
    // Hide navigation bar before returning to tab controller
    
    self.navigationController?.navigationBarHidden = true
    
    if segue.identifier == Constants.Segues.FromAddDetailsToTabBar {
      
      let tabBarController = segue.destinationViewController as! UITabBarController
      
      if self.segueToReturn == Constants.Segues.FromAddDetailsToNotExpired {
      
        let navigationController = tabBarController.viewControllers?[1] as! UINavigationController
        _ = navigationController.viewControllers[0] as! NotExpiredTableViewController
        
      } else {
      
        let navigationController = tabBarController.viewControllers?[2] as! UINavigationController
        _ = navigationController.viewControllers[0] as! ExpiredTableViewController
      
      }
      
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
  
  // MARK: - take picture
  
  @IBAction func takePicture_TouchUpInside(sender: AnyObject) {
    imagePicker =  UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .Camera
    
    presentViewController(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    imagePicker.dismissViewControllerAnimated(true, completion: nil)
    image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    
  }
  
  func imagePath (reminder: Int) -> String {
    
    // Define the specific path, image name
    
    let myImageName = "img" + String(reminder) +  ".png"
    let imagePath = imageController.fileInDocumentsDirectory(myImageName)
    
    return imagePath
    
  }
  
  func savePicture (reminder: Int) {
    
    if let image = image.image {
      
      imageController.saveImage(image, path: self.imagePath(reminder))
      
    } else {
      
      // Cold not save date error
      
    }
    
  }
  
}
