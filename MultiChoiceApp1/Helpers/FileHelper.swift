//
//  ReadJsonFile.swift
//  Scoolia
//
//  Created by Mohamed Shaat on 7/20/20.
//  Copyright © 2020 shaat. All rights reserved.
//

import UIKit

class FileHelper: NSObject {
    
    class func getData(name: String, withExtension: String = "json") -> NSData {
        
        guard let path = Bundle.main.path(forResource: name, ofType: "json"),
            let data = NSData(contentsOfFile: path) else {
                return NSData()
        }
        
        return data
        
    }
    
}
