//
//  DataService.swift
//  QiuTuiJian
//
//  Created by Ping on 23/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

// Reference: http://stackoverflow.com/questions/24024549/dispatch-once-singleton-model-in-swift

import Foundation
import CoreData

let dataServiceInstance = DataService()
class DataService {
    // Singleton
    class var sharedInstance : DataService {
        return dataServiceInstance
    }
    
    var ctx:NSManagedObjectContext
    init() {
        println("Initializing the singleton DataServie.")
        ctx = NSManagedObjectContext()
    }
    
}
