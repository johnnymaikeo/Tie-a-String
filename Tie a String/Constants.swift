//
//  Constants.swift
//  Tie a String
//
//  Created by Johnny on 12/8/15.
//  Copyright (c) 2015 Johnny Ferreira Corp. All rights reserved.
//

import Foundation

struct Constants {
  struct Segues {
        
    static let FromJoinToHome = "SegueJoinToHome"
        
    static let FromEnterToHome = "SegueEnterToHome"
        
    static let FromNotExpiredToSelectCategory = "SegueNotExpiredToSelectCaregory"
        
    static let FromExpiredToSelectCategory = "SegueExpiredToSelectCaregory"
      
    static let FromSelectCategoryToAddDetails = "SegueSelectCategoryToAddDetails"
      
    static let FromAddDetailsToNotExpired = "SegueAddDetailsToNotExpired"
      
    static let FromAddDetailsToExpired = "SegueAddDetailsToExpired"
    
    static let FromAddDetailsToTabBar = "SegueAddDetailsToTabBarController"
    
    static let FromNonExpiredToAddDetails = "SegueNonExpiredToAddDetails"
    
    static let FromExpiredToAddDetails = "SegueExpiredToAddDetails"
        
  }
  

  struct Identifiers {
    
    static let CategorySelectionCell = "CategorySelectionCollectionViewCell"
    
  }
}
