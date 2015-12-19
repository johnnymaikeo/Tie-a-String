//
//  Users+CoreDataProperties.swift
//  Tie a String
//
//  Created by Johnny on 12/18/15.
//  Copyright © 2015 Johnny Ferreira Corp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Users {

    @NSManaged var name: String?
    @NSManaged var email: String?
    @NSManaged var password: String?
    @NSManaged var token: String?
    @NSManaged var expiration: NSDate?

}
