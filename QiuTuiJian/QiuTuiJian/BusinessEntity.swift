//
//  BusinessEntity.swift
//  QiuTuiJian
//
//  Created by Ping on 5/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

public class BusinessEntity: AbstractEntity {
    @NSManaged
    public var category: String

    @NSManaged
    public var name: String
    
    @NSManaged
    public var uuid: String
    
    @NSManaged
    public var mobile: Mobile
    
    @NSManaged
    public var email: String
    
    // INIT data for creation. It's called only once in whole life-cycle.
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        
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
