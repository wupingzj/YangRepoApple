//
//  Mobile.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

public class Mobile: AbstractEntity {
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
        
        //println("**** My class is \(self.entity.managedObjectClassName)")
        
        // *********** IMPORTANT: *****************
        // YOU SHOULD NOT do anything in this minit method.
        // Otherwise, problem could be introduced into undo and redo behavior.
        // Read method documentation
        
        
        // YOU SHOULD NOT set the value for the fields. Otherwise, the FetchRequest does NOT populate these fields from data store!!!!
        // If you do set the value for some fields, the value of these fields will NOT be retrieved from database.
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        countryCode = "64"
        areaCode = "4"
        //number = "12345678"
        //phoneModel = "iPhone 5"
    }
    
    public class func createEntity() -> Mobile {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let MobileED: NSEntityDescription = NSEntityDescription.entityForName("Mobile", inManagedObjectContext: ctx)
        let newMobile = Mobile(entity: MobileED, insertIntoManagedObjectContext: ctx)
        
        return newMobile
    }
}