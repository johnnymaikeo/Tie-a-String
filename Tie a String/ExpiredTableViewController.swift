//
//  ExpiredTableViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/13/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class ExpiredTableViewController: UITableViewController {

  let dataController:DataController = DataController()
  var categories: [Categories] = []
  var reminders: [Reminders] = []
  var reminderMatrix: NSMutableArray = []
  var selectedReminder: Reminders!
  
  override func viewDidLoad() {
        
    super.viewDidLoad()
    
    self.categories = self.dataController.fetchCategories()
        
  }
    
  override func viewWillAppear(animated: Bool) {
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButton_TouchUpInside");
    
    self.reminders = self.dataController.fetchExpiredReminders()
    self.convertReminderArrayToMatrix()
    
    // refresh table view data
    
    self.tableView.reloadData()
    
  }
  
  internal func convertReminderArrayToMatrix() {
    
    // reset arrays
    
    self.reminderMatrix = []
    
    // initialize arrays of reminders
    
    for _ in self.categories {
      self.reminderMatrix.addObject(NSMutableArray())
    }
    
    // populate matrix
    
    for reminder in self.reminders {
      let index = Int(reminder.category!)
      self.reminderMatrix[index].addObject(reminder)
    }
    
  }
    
  func addButton_TouchUpInside () {
        
    self.performSegueWithIdentifier(Constants.Segues.FromExpiredToSelectCategory, sender: self)
        
  }
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == Constants.Segues.FromExpiredToSelectCategory {
        
      let viewController = segue.destinationViewController as! SelectCategoryCollectionViewController
        
      viewController.segueToReturn = Constants.Segues.FromAddDetailsToExpired
      
    } else if segue.identifier == Constants.Segues.FromExpiredToAddDetails {
    
      let viewController = segue.destinationViewController as! AddDetailsViewController
      
      viewController.segueToReturn = Constants.Segues.FromAddDetailsToExpired
      viewController.action = "Edit"
      viewController.reminder = self.selectedReminder
    
    }
  }
  
  
  // MARK: - Table View Controller
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    // Return the number of sections.
    return self.categories.count
    
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    // Return the number of rows in the section.
    return self.reminderMatrix[section].count
    
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.categories[section].name
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("ExpiredCell",
      forIndexPath: indexPath)
    
    let reminder = self.reminderMatrix[indexPath.section][indexPath.row] as! Reminders
    cell.textLabel!.text = reminder.reminder
    return cell
    
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    // Go to Details View Controller with Edit option
    
    self.selectedReminder = self.reminderMatrix[indexPath.section][indexPath.row] as! Reminders
    
    performSegueWithIdentifier(Constants.Segues.FromExpiredToAddDetails, sender: self)
    
  }
  
  override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {

    let completed = UITableViewRowAction(style: .Normal, title: "Completo") { action, index in
    
      let item = self.reminderMatrix[indexPath.section][indexPath.row] as! Reminders
      
      let reminder = item.reminder
      let expiration = item.expiration
      let alert = item.alert == 1 ? true : false
      let id = Int(item.id!)
      
      if self.dataController.edtReminder(id, alert: alert, expiration: expiration!, reminder: reminder!, completed: true) {
        
        // TODO: refresh data and reload table source
        
        
        self.tableView.reloadData()
        
      } else {
        // Show alert on error
      }
      
    }
    completed.backgroundColor = UIColor.lightGrayColor()
    
    let edit = UITableViewRowAction(style: .Normal, title: "Editar") { action, index in
      
      self.performSegueWithIdentifier(Constants.Segues.FromExpiredToAddDetails, sender: self)
      
    }
    edit.backgroundColor = UIColor.blueColor()
    
    let delete = UITableViewRowAction(style: .Normal, title: "Remover") { action, index in
      NSLog("share button tapped")
    }
    delete.backgroundColor = UIColor.redColor()
    
    return [completed, edit, delete]
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // the cells you would like the actions to appear needs to be editable
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    // you need to implement this method too or you can't swipe to display the actions
  }

  
}
