//
//  Reminders+CoreDataProperties.swift
//  Tie a String
//
//  Created by Johnny on 12/15/15.
//  Copyright © 2015 Johnny Ferreira Corp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Reminders {

    @NSManaged var id: NSNumber?
    @NSManaged var reminder: String?
    @NSManaged var expiration: NSDate?
    @NSManaged var alert: NSNumber?
    @NSManaged var expired: NSNumber?
    @NSManaged var category: NSNumber?

}
