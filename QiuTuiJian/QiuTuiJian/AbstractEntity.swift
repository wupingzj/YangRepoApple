//
//  AbstractEntity.swift
//  QiuTuiJian
//
//  Created by Ping on 31/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//
//  Foundation Entity class for entity classes

import Foundation
import CoreData

public class AbstractEntity: NSManagedObject {
    @NSManaged
    public var uuid: String
    
    // INIT data for creation. It's called only once in whole life-cycle.
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.uuid = NSUUID.UUID().UUIDString
    }
}
