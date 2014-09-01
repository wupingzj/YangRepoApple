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
    public var createdDate: NSDate
}
