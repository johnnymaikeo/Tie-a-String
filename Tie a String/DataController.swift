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
        
        let categories = ["Alimentos", "Automóvel", "Documentos", "Financeiro", "Residência", "Saúde"];
        
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
    
    internal func hasCategories() -> Bool {
        
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
    
    internal func isExpired(date: NSDate) -> Bool {
        
        let currentDate = NSDate()
        
        if currentDate.compare(date) == NSComparisonResult.OrderedDescending {
            NSLog("is expired")
            return true;
        } else {
            NSLog("is not expired")
            return false;
        }
        
    }
    
    internal func idForReminder() -> Int {
    
        let fetchRequest = NSFetchRequest(entityName: "Reminders")
        
        do {
            
            let results = try self.managedContext.executeFetchRequest(fetchRequest)
            return results.count
            
        } catch {
            fatalError("Failure to fech \(error)")
        }
    
    }
    
    func addReminder(alert: Bool, category: Int, expiration: NSDate, reminder: String, active: Bool) -> Bool {
    
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Reminders", inManagedObjectContext: self.managedContext) as! Reminders
        
        entity.setValue(alert, forKey: "alert")
        entity.setValue(category, forKey: "category")
        entity.setValue(expiration, forKey: "expiration")
        entity.setValue(self.isExpired(expiration), forKey: "expired")
        entity.setValue(self.idForReminder(), forKey: "id")
        entity.setValue(reminder, forKey: "reminder")
        entity.setValue(active, forKey: "active")
        
        do {
            try self.managedContext.save()
            return true;
        } catch {
            return false;
        }
    
    }
    
    internal func fetchRemindersToSetAsExpired() -> [Reminders] {
    
        let fetchRequest = NSFetchRequest(entityName: "Reminders")
        
        // Check for non flagged reminders
        
        let predicateExpired = NSPredicate(format: "expired == false")
        
        // With expiration date before today
        
        let date = NSDate()
        let yesterday = date.dateByAddingTimeInterval(-60*60*24)
        
        let predicateExpiration = NSPredicate(format: "expiration <= %@", yesterday)
        
        let compound = NSCompoundPredicate(type: .AndPredicateType, subpredicates: [predicateExpired, predicateExpiration])
        
        fetchRequest.predicate = compound
        
        do {
        
            let results = try self.managedContext.executeFetchRequest(fetchRequest) as! [Reminders]
            return results
            
        } catch {
            
            fatalError("Failure to fetch: \(error)")
            
        }
        
        return []
        
    }
    
    internal func setExpiredReminders () {
    
        let reminders = self.fetchRemindersToSetAsExpired()
        
        for reminder in reminders {
        
            reminder.setValue(true, forKey: "expired")

            do {
                
                try self.managedContext.save()
            
            } catch {
            
                fatalError("Failure to save: \(error)")
            
            }
        
        }
        
    }
    
    func fetchNonExpiredReminders() -> [Reminders] {
        
        self.setExpiredReminders()
        
        let fetchRequest = NSFetchRequest(entityName: "Reminders")
        
        // filter non expired reminders
        
        let predicate = NSPredicate(format: "expired == false")
        
        fetchRequest.predicate = predicate
        
        // sort results by expiration date
        
        let sortDescriptor = NSSortDescriptor(key: "expiration", ascending: true)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            
            let results = try self.managedContext.executeFetchRequest(fetchRequest) as! [Reminders]
            return results
            
        } catch {
            fatalError("Failure to fetch: \(error)")
        }
        
        return []
        
    }
    
    func fetchExpiredReminders() -> [Reminders] {
    
        self.setExpiredReminders()
        
        let fetchRequest = NSFetchRequest(entityName: "Reminders")
        
        // filter expired requests
        
        let predicate = NSPredicate(format: "expired == true")
        
        fetchRequest.predicate = predicate
        
        // sort results by expiration date
        
        let sortDescriptor = NSSortDescriptor(key: "expiration", ascending: true)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
        
            let results = try self.managedContext.executeFetchRequest(fetchRequest) as! [Reminders]
            return results
        
        } catch {
        
            fatalError("Failure to fetch: \(error)")
        
        }
        
        return []
        
    }
    
    func edtReminder(id: Int, alert: Bool, expiration: NSDate, reminder: String, completed: Bool) -> Bool {
        
        let fetchRequest = NSFetchRequest(entityName: "Reminders")
        
        // filter for specific id
        
        let predicate = NSPredicate(format: "id == %d", id)
        
        fetchRequest.predicate = predicate
        
        do {
        
            let reminders = try self.managedContext.executeFetchRequest(fetchRequest) as! [Reminders]
            
            for item in reminders {
            
                item.setValue(expiration, forKey: "expiration")
                item.setValue(reminder, forKey: "reminder")
                item.setValue(alert, forKey: "alert")
                item.setValue(completed, forKey: "active")
                
                do {
                    
                    try self.managedContext.save()
                    
                    return true;
                    
                } catch {
                    
                    fatalError("Failure to save: \(error)")
                    
                }
            
            
            }
        
        } catch {
        
            fatalError("Failure to fetch: \(error)")
        
        }
        
        return false
    }
    
    func deleteReminder(id: Int) -> Bool {
    
        let fetchRequest = NSFetchRequest(entityName: "Reminders")
        
        // filter for specific id
        
        let predict = NSPredicate(format: "id == %d", id)
        
        fetchRequest.predicate = predict
        
        do {
        
            let reminders = try self.managedContext.executeFetchRequest(fetchRequest) as! [Reminders]
            
            for item in reminders {
                NSLog("%@", item.reminder!)
                self.managedContext.deleteObject(item)
                
                do {
                
                    try self.managedContext.save()
                    
                    return true;
                    
                } catch {
                
                    fatalError("Failure to save: \(error)")
                
                }
                
            }
        
        } catch {
        
            fatalError("Failure to fetch: \(error)")
        
        }
        
        return false
    
    }
    
}
