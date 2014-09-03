//
//  Mobile.swift
//  QiuTuiJian
//
//  Created by Ping on 27/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

public class Event: AbstractEntity {
    @NSManaged
    public var type: Int
    
    @NSManaged
    public var text: String
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.createdDate = NSDate()
    }
    
    public class func createEntity() -> Event {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("Event", inManagedObjectContext: ctx)
        let newEntity = Event(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newEntity
    }
}