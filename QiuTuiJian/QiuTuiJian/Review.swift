//
//  Mobile.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//
//  A review entity of a Performance

import Foundation
import CoreData

public class Review: AbstractEntity {
    @NSManaged
    public var text: String
    
    @NSManaged
    public var helpful: Bool
    
    @NSManaged
    public var performance: Performance
    
    @NSManaged
    public var user: User
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
    }
    
    public class func createEntity() -> Review {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("Review", inManagedObjectContext: ctx)
        let newEntity = Review(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newEntity
    }
}