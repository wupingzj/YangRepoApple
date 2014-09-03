//
//  BusinessEntity.swift
//  QiuTuiJian
//
//  Created by Ping on 5/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

// The following objc annotation simply allows this entity to be referenced in object-C code. But it needs a bridging code to make it work
//@objc(BusinessEntity)
public class BusinessEntity: AbstractEntity {
    @NSManaged
    public var category: String

    @NSManaged
    public var name: String
    
    @NSManaged
    public var uuid: String
    
    @NSManaged
    public var phone: String?
    
    @NSManaged
    public var email: String?
    
    // relationships
    @NSManaged
    public var address: Address
    
    @NSManaged
    public var businessPerson: BusinessPerson?
    
    @NSManaged
    public var performance: Performance?
    
    @NSManaged
    public var promotionRank: UInt16
    
    // INIT data for creation. It's called only once in whole life-cycle.
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        
        // createdDate cannot be initialized in AbstractEntity
        self.uuid = NSUUID.UUID().UUIDString
        self.createdDate = NSDate()
    }
    
    // This method is for manually creating test data
    public class func createEntity() -> BusinessEntity {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("BusinessEntity", inManagedObjectContext: ctx)
        let newBusinessEntity = BusinessEntity(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newBusinessEntity
    }
}
