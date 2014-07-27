//
//  MobilePhone.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

class MobilePhone: NSManagedObject{
    @NSManaged
    var countryCode:NSString
    
    @NSManaged
    var areaCode:NSString

    @NSManaged
    var phoneNumber:NSString

    @NSManaged
    var phoneModel:NSString
    
    init(entity: NSEntityDescription!, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        println("Initializing the singleton DataServie.")
        countryCode = "64"
        areaCode = "4"
        phoneNumber = "12345678"
        phoneModel = "iPhone 5"
    }
}