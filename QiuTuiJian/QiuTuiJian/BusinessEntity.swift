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
    
    public class func createEntity() -> BusinessEntity {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("BusinessEntity", inManagedObjectContext: ctx)
        let newBusinessEntity = BusinessEntity(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newBusinessEntity
    }
}
