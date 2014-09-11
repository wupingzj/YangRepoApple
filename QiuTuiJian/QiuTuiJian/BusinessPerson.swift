//
//  Mobile.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//
//  BusinessPerson

import Foundation
import CoreData

public class BusinessPerson: Person {
    @NSManaged
    public var anonymous: Bool
    
    @NSManaged
    public var businessEntity: BusinessEntity
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.uuid = NSUUID.UUID().UUIDString
        self.createdDate = NSDate()
    }
    
    public class func createEntity() -> BusinessPerson {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("BusinessPerson", inManagedObjectContext: ctx)
        let newEntity = BusinessPerson(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newEntity
    }
    
    public func getNormalizedName() -> String {
        return self.firstName + " " + self.lastName
    }
}