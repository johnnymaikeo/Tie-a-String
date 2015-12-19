//
//  ResultsTableViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/18/15.
//  Copyright © 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

  var startDate: NSDate!
  var endDate: NSDate!
  var category: Int!
  var keyword: String!
  
  let dataController = DataController()
  var reminders: [Reminders]!
  var selectedReminder: Reminders!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Registering custom collection view cell
    
    tableView!.registerNib(UINib(nibName: Constants.Identifiers.ReminderTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Identifiers.ReminderTableViewCell)

    // Set page title
    
    self.title = "Resultado"
    
  }

  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(true)
    
    // Show tab bar on creating/editing reminder
    self.tabBarController?.tabBar.hidden = false
    
    getData()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func getData() {
  
    self.reminders = dataController.fetchFilteredReminders(self.startDate, endDate: self.endDate, category: self.category, keyword: self.keyword)
    
    self.tableView.reloadData()
  
  }
  
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    // Return the number of sections.
    return 1
    
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    // Return the number of rows in the section.
    return self.reminders.count
    
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCellWithIdentifier(Constants.Identifiers.ReminderTableViewCell, forIndexPath: indexPath) as! ReminderTableViewCell
    
    let reminder = self.reminders[indexPath.row] 
    
    cell.reminderLabel.text = reminder.reminder
    
    let id = Int(reminder.id!)
    let imageController = ImageController()
    
    if let loadedImage = imageController.loadImageFromPath(imageController.imagePath(id)) {
      
      cell.reminderImage.image = loadedImage
      
    } else {
      
      cell.reminderImage.image = UIImage(named: reminder.reminder!)
      
    }
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
    cell.expireDateLabel.text = dateFormatter.stringFromDate(reminder.expiration!)
    
    return cell
    
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    // Go to Details View Controller with Edit option
    
    self.selectedReminder = self.reminders[indexPath.row] 
    
    performSegueWithIdentifier(Constants.Segues.FromResultsToAddDetails, sender: self)
    
  }
  
  override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
    self.selectedReminder = self.reminders[indexPath.row] 
    
    let completed = UITableViewRowAction(style: .Normal, title: "Completo") { action, index in
      
      let item = self.reminders[indexPath.row]
      
      let reminder = item.reminder
      let expiration = item.expiration
      let alert = item.alert == 1 ? true : false
      let id = Int(item.id!)
      
      let result = self.dataController.edtReminder(id, alert: alert, expiration: expiration!, reminder: reminder!, completed: true)
      
      if result >= 0 {
        
        self.getData()
        
      } else {
        // Show alert on error
      }
      
    }
    completed.backgroundColor = UIColor.lightGrayColor()
    
    let edit = UITableViewRowAction(style: .Normal, title: "Editar") { action, index in
      
      self.performSegueWithIdentifier(Constants.Segues.FromResultsToAddDetails, sender: self)
      
    }
    edit.backgroundColor = UIColor.blueColor()
    
    let delete = UITableViewRowAction(style: .Normal, title: "Remover") { action, index in
      
      let item = self.reminders[indexPath.row]
      let index = Int(item.id!)
      
      if self.dataController.deleteReminder(index) {
        
        self.getData()
        
      } else {
        
        // Show alert on error
        
      }
      
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
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // change back button text
    
    let backItem = UIBarButtonItem()
    backItem.title = "Back"
    navigationItem.backBarButtonItem = backItem
    
    if segue.identifier == Constants.Segues.FromResultsToAddDetails {
      
      let viewController = segue.destinationViewController as! AddDetailsViewController
      
      viewController.segueToReturn = Constants.Segues.FromResultsToAddDetails
      viewController.action = "Edit"
      viewController.reminder = self.selectedReminder
      
    }
  }
}
