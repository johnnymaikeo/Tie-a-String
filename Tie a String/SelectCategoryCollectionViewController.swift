//
//  SelectCategoryCollectionViewController.swift
//  Tie a String
//
//  Created by Johnny on 12/13/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class SelectCategoryCollectionViewController: UICollectionViewController {
  
  let dataController = DataController()
  var categories: [Categories] = []
  var selectedIndexRow: Int = -1
  var segueToReturn: String = ""
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
        
    // Set page title
    self.title = "Category Selection"

    // Registering custom collection view cell
    collectionView!.registerNib(UINib(nibName: Constants.Identifiers.CategorySelectionCell, bundle: nil), forCellWithReuseIdentifier: Constants.Identifiers.CategorySelectionCell)
    
    // Fetch categories
    self.categories = dataController.fetchCategories()

  }
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.categories.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.Identifiers.CategorySelectionCell, forIndexPath: indexPath) as! CategorySelectionCollectionViewCell
    
    cell.categoryLabel.text = self.categories[indexPath.row].name
    
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    self.selectedIndexRow = indexPath.row;
  
    self.performSegueWithIdentifier(Constants.Segues.FromSelectCategoryToAddDetails, sender: self)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == Constants.Segues.FromSelectCategoryToAddDetails {
      
      if selectedIndexRow > 0 {
      
        let viewController = segue.destinationViewController as! AddDetailsViewController
        let category = categories[self.selectedIndexRow]
        
        viewController.categoryIndex = Int(category.id!)
        viewController.category = category.name!
        viewController.segueToReturn = self.segueToReturn
        
      }
    }
  }

}
