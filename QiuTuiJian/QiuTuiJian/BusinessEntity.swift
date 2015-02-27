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
    
    @NSManaged
    public var desc: String?
    
    // INIT data for creation. It's called only once in whole life-cycle.
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        
        // createdDate cannot be initialized in AbstractEntity
        self.uuid = NSUUID().UUIDString
        self.createdDate = NSDate()
    }
    
    // This method is for manually creating test data
    public class func createEntity() -> BusinessEntity {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("BusinessEntity", inManagedObjectContext: ctx)!
        let newBusinessEntity = BusinessEntity(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newBusinessEntity
    }
    
    // This must be telephone
    public func getNormalizedPhone() -> String? {
        if phone != nil {
            return self.phone
        }
        
        return nil
    }

    public func getMobile() -> String? {
        if (businessPerson != nil) {
            if (businessPerson!.mobile != nil) {
                return businessPerson!.mobile!.getNormalizedNumber()
            }
        }
        
        return nil
    }
    
    public func getContactName() -> String {
        if (businessPerson != nil) {
            return businessPerson!.getNormalizedName() + "/" + name
        } else {
            return name
        }
    }
}
