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

// A person is actually abstract in this app because a person is either a BuinessPerson or a User.
public class Person: AbstractEntity {
    @NSManaged
    public var uuid: String
    
    @NSManaged
    public var firstName: String
    
    @NSManaged
    public var lastName: String
    
    @NSManaged
    public var email: String?
    
    @NSManaged
    public var mobile: Mobile?
    
//    public override func awakeFromInsert() {
//        super.awakeFromInsert()
//        
//        self.uuid = NSUUID.UUID().UUIDString
//        self.createdDate = NSDate()
//    }
}