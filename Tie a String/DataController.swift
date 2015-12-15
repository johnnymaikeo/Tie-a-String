//
//  DataModelController.swift
//  Tie a String
//
//  Created by Johnny on 12/14/15.
//  Copyright © 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {
    
    var appDelegate: AppDelegate
    var managedContext: NSManagedObjectContext
    
    override init() {
        self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedContext = self.appDelegate.managedObjectContext
    }
    
    func seedCategories() {
        
        // Check if core data is already populated
        
        if (self.hasCategories()) {
            return
        }
        
        let categories = ["Alimentos", "Automóvel", "Residência", "Financeiro", "Saúde", "Documentos"];
        
        let moc = self.appDelegate.managedObjectContext
        
        var index: Int
        for (index = 0; index < categories.count; index++) {
            
            let entity = NSEntityDescription.insertNewObjectForEntityForName("Categories", inManagedObjectContext: self.managedContext) as! Categories
            
            entity.setValue(0, forKey: "id")
            entity.setValue("Alimentos", forKey: "name")
            
        }
        
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    func hasCategories() -> Bool {
        
        let fetchRequest = NSFetchRequest(entityName: "Categories")
        
        do {
            let results = try self.managedContext.executeFetchRequest(fetchRequest)
            if (results.count > 0) {
                return true
            } else {
                return false
            }
        } catch {
            fatalError("Failure to fetch: \(error)")
        }
        
    }
    
    func fetchCategories() -> [Categories] {

        let fetchRequest = NSFetchRequest(entityName: "Categories")
        
        // sort results by name
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            
            let results = try self.managedContext.executeFetchRequest(fetchRequest) as! [Categories]
            return results
            
        } catch let error as NSError {
            fatalError("Failure to fech: \(error)")
        }
        
        return []
        
    }
    
}
