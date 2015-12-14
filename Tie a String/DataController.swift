//
//  DataAccessLayer.swift
//  Tie a String
//
//  Created by Johnny on 12/13/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import Foundation
import CoreData

class DataController {

    func initDataModel () {
    
        initCategories()
        
    }
    
    
    func initCategories () {
    
        let categoriesArray = NSArray(objects: "Alimentos", "Documentos", "Automóvel", "Saúde", "Financeiro", "Residência", "Contas")
        
        let moc = self.managedObjectContext
        let categoriesFetch = NSFetchRequest(entityName: "Categories")
        
        do {
        
            let fetchedCategories = try moc.executeFectchedRequest(fetchCategoriesFetch) as! [Categories]
        
        } catch {
        
            fatalError("Failed to fetch Categories")
            
        }
        
    }
}