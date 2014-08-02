//
//  MobilePhone.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

public class MobilePhone: NSManagedObject{
    @NSManaged
    public var countryCode:String
    
    @NSManaged
    public var areaCode:String

    // phone number
    @NSManaged
    public var number:String

    // phone model
    @NSManaged
    public var phoneModel:String
    
    public init(entity: NSEntityDescription!, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        println("Initializing the singleton DataServie.")
        println("**** My class is \(self.entity.managedObjectClassName)")
        //println("entity = \(entity)")
        
        // *********** IMPORTANT: *****************
        // YOU SHOULD NOT set the value for the fields. Otherwise, the FetchRequest does NOT populate these fields from data store!!!!
        // If you do set the value for some fields, the value of these fields will NOT be retrieved from database.
        
//        NEVER POPULATE FIELDS here
//        countryCode = "64"
//        areaCode = "4"
//        number = "4444444 - init"
//        phoneModel = "iPhone 5 - init"
    }
    
    public func initData() {
        // ONLY INIT data for creation!!!
            countryCode = "64"
            areaCode = "4"
            number = "12345678"
            phoneModel = "iPhone 5"
    }
}