//
//  NotExpiredTableViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/13/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class NotExpiredTableViewController: UITableViewController {

  let dataController:DataController = DataController()
  var categories: [Categories] = []
  var reminders: [Reminders] = []
  var reminderMatrix: NSMutableArray = []
  
  override func viewDidLoad() {
  
    super.viewDidLoad()
    
    self.categories = self.dataController.fetchCategories()
        
  }
    
  override func viewWillAppear(animated: Bool) {
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButton_TouchUpInside");
    
    self.reminders = self.dataController.fetchNonExpiredReminders()
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
    
    self.performSegueWithIdentifier(Constants.Segues.FromNotExpiredToSelectCategory, sender: self)
    
  }
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == Constants.Segues.FromNotExpiredToSelectCategory {
      
      let viewController = segue.destinationViewController as! SelectCategoryCollectionViewController
      
      viewController.segueToReturn = Constants.Segues.FromAddDetailsToNotExpired
      
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

    let cell = tableView.dequeueReusableCellWithIdentifier("NonExpiredCell",
    forIndexPath: indexPath)
    
    let reminder = self.reminderMatrix[indexPath.section][indexPath.row] as! Reminders
    cell.textLabel!.text = reminder.reminder
    return cell
    
  }
  
}
