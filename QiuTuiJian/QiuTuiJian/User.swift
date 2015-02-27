//
//  Mobile.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

public class User: Person {
    @NSManaged
    public var anonymous: Bool
    
    @NSManaged
    public var reviews: [Review]
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.uuid = NSUUID().UUIDString
        self.createdDate = NSDate()
    }
    
    public class func createEntity() -> User {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("User", inManagedObjectContext: ctx)!
        let newEntity = User(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newEntity
    }
}