//
//  ImageController.swift
//  Tie a String
//
//  Created by Johnny on 12/17/15.
//  Copyright © 2015 Johnny Ferreira Corp. All rights reserved.
//

import UIKit

class ImageController: NSObject {

  
  // Save and load Image
  
  internal func getDocumentsURL() -> NSURL {
    
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    
    return documentsURL
    
  }
  
  internal func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    
    return fileURL.path!
    
  }
  
  func saveImage (image: UIImage, path: String ) -> Bool{
    
    let pngImageData = UIImagePNGRepresentation(image)

    let result = pngImageData!.writeToFile(path, atomically: true)
    
    return result
    
  }
  
  func loadImageFromPath(path: String) -> UIImage? {
    
    let image = UIImage(contentsOfFile: path)
    
    if image == nil {
      
      print("missing image at: \(path)")
    }

    return image
    
  }
  
}
