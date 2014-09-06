//
//  Mobile.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//
//  Mobile phone details

import Foundation
import CoreData

public class Mobile: AbstractEntity {
    // phone number
    @NSManaged
    public var number:String
    
    // phone model
    @NSManaged
    public var phoneModel:String
    
    @NSManaged var businessEntity: BusinessEntity
    
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
        //number = "12345678"
        //phoneModel = "iPhone 5"
    }
    
    public class func createEntity() -> Mobile {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let MobileED: NSEntityDescription = NSEntityDescription.entityForName("Mobile", inManagedObjectContext: ctx)
        let newMobile = Mobile(entity: MobileED, insertIntoManagedObjectContext: ctx)
        
        return newMobile
    }
    
    public func getNormalizedNumber() -> String {
        // TODO normalize the mobile phone number
        return number;
    }
}