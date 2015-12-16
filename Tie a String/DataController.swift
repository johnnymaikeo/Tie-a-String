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
        
        var index: Int
        for (index = 0; index < categories.count; index++) {
            
            let entity = NSEntityDescription.insertNewObjectForEntityForName("Categories", inManagedObjectContext: self.managedContext) as! Categories
            
            entity.setValue(index, forKey: "id")
            entity.setValue(categories[index], forKey: "name")
            
            do {
                try self.managedContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
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
    
    func isExpired(date: NSDate) -> Bool {
        
        let currentDate = NSDate()
        
        if currentDate.compare(date) == NSComparisonResult.OrderedDescending {
            return true;
        } else {
            return false;
        }
        
    }
    
    func idForReminder() -> Int {
    
        let fetchRequest = NSFetchRequest(entityName: "Reminders")
        
        do {
            
            let results = try self.managedContext.executeFetchRequest(fetchRequest)
            return results.count
            
        } catch {
            fatalError("Failure to fech \(error)")
        }
    
    }
    
    func addReminder(reminder: Reminders) -> Bool {
    
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Reminders", inManagedObjectContext: self.managedContext) as! Reminders
        
        entity.setValue(reminder.alert, forKey: "alert")
        entity.setValue(reminder.category, forKey: "category")
        entity.setValue(reminder.expiration, forKey: "expiration")
        entity.setValue(self.isExpired(reminder.expiration!), forKey: "expired")
        entity.setValue(self.idForReminder(), forKey: "id")
        entity.setValue(reminder.reminder, forKey: "reminder")
        
        do {
            try self.managedContext.save()
            return true;
        } catch {
            return false;
        }
    
    }
    
}
