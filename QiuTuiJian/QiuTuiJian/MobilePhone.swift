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
    var countryCode:String
    
    @NSManaged
    var areaCode:String

    // phone number
    @NSManaged
    var number:String

    // phone model
    @NSManaged
    var phoneModel:String
    
    init(entity: NSEntityDescription!, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        println("Initializing the singleton DataServie.")
        println("**** My class is \(self.entity.managedObjectClassName)")
        
        countryCode = "64"
        areaCode = "4"
        number = "12345678"
        phoneModel = "iPhone 5"
    }
}