//
//  Mobile.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//
//  Performance of a BusinessEntity

import Foundation
import CoreData

public class Performance: AbstractEntity {
    // Here, integer is scalar data type. Core data supports only three integers: 16, 32 and 64 bits.
    // Otherwise, refer to page https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CoreData/Articles/cdNSAttributes.html
    
    @NSManaged
    public var rank: UInt32
    
    // phone model
    @NSManaged
    public var star: UInt32
    
    @NSManaged
    public var businessEntity: BusinessEntity
    
    @NSManaged
    public var reviews: [Review]
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        createdDate = NSDate()
        
        rank = 0
        star = 5
    }
    
    public class func createEntity() -> Performance {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("Performance", inManagedObjectContext: ctx)
        let newEntity = Performance(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newEntity
    }
}