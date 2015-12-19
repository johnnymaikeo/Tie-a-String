//
//  SearchViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/18/15.
//  Copyright © 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

  @IBOutlet weak var startDateTextBox: UITextField!
  @IBOutlet weak var endDateTextBox: UITextField!
  @IBOutlet weak var categoryTextBox: UITextField!
  @IBOutlet weak var keywordTextBox: UITextField!
  @IBOutlet weak var startDatePicker: UIDatePicker!
  @IBOutlet weak var endDatePicker: UIDatePicker!
  @IBOutlet weak var categoryListPicker: UIPickerView!
  
  var selectedCategory: Int!
  
  var categories: [Categories]!
  var dataController: DataController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Hide all pickers
    dismissDateAndListPickers()
    
    // Dismiss keyboard if toucher anywhere else
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissDateAndListPickers")
    view.addGestureRecognizer(tap)
    
    // Setting up date piker
    startDatePicker.addTarget(self, action: Selector("startDatePicker_Changed:"), forControlEvents: UIControlEvents.ValueChanged)
    
    // Setting up date piker
    endDatePicker.addTarget(self, action: Selector("endDatePicker_Change:"), forControlEvents: UIControlEvents.ValueChanged)

    // Get Data to Populate Picker View
    self.categoryListPicker.delegate = self
    self.dataController = DataController()
    self.categories = dataController.fetchCategories()
    
    // Dismiss keyboard on press return
    self.keywordTextBox.delegate = self;
    
    // Add search button to the navigation bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "searchButton_TouchUpInside");
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func startDateTextBox_EditingDidBegin(sender: AnyObject) {
    
    dismissDateAndListPickers()
    
    self.startDatePicker.hidden = false
    
  }
  
  @IBAction func endDateTextBox_EditDidBegin(sender: AnyObject) {
    
    dismissDateAndListPickers()
    
    self.endDatePicker.hidden = false
    
  }
  
  @IBAction func categoryTextBox_EditingDidBegin(sender: AnyObject) {
    
    dismissDateAndListPickers()
    
    self.categoryListPicker.hidden = false
    self.categoryTextBox.text = self.categories[0].name!
    
  }
  
  func searchButton_TouchUpInside () {
  
    self.performSegueWithIdentifier(Constants.Segues.FromSearchToResults, sender: self)

  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // change back button text
    
    let backItem = UIBarButtonItem()
    backItem.title = "Back"
    navigationItem.backBarButtonItem = backItem
    
    if segue.identifier == Constants.Segues.FromSearchToResults {
      
      let viewController = segue.destinationViewController as! ResultsTableViewController
      viewController.category = self.selectedCategory
      
      if self.startDateTextBox.text == "" {
        viewController.startDate = nil
      } else {
        viewController.startDate = self.startDatePicker.date
      }
      
      if self.endDateTextBox.text == "" {
        viewController.endDate = nil
      } else {
        viewController.endDate = self.endDatePicker.date
      }
      
      if self.keywordTextBox.text == "" {
        viewController.keyword = nil
      } else {
        viewController.keyword = self.keywordTextBox.text
      }
      
    }
  }
  
  func dismissDateAndListPickers() {
  
    self.startDatePicker.hidden = true
    self.endDatePicker.hidden = true
    self.categoryListPicker.hidden = true
    view.endEditing(true)
  
  }
  
  func startDatePicker_Changed(datePicker:UIDatePicker) {
    
    let dateFormatter = NSDateFormatter()
    
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    
    let strDate = dateFormatter.stringFromDate(datePicker.date)
    self.startDateTextBox.text = strDate
    
  }
  
  func endDatePicker_Change(datePicker:UIDatePicker) {
    
    let dateFormatter = NSDateFormatter()
    
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    
    let strDate = dateFormatter.stringFromDate(datePicker.date)
    self.endDateTextBox.text = strDate
    
  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    
    return 1
    
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return self.categories.count
    
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    return self.categories[row].name
    
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
  {
    
    self.selectedCategory = row;
    self.categoryTextBox.text = self.categories[row].name!
    
  }
  
}
