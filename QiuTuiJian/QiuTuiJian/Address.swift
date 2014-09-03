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

public class Address: AbstractEntity {
    @NSManaged
    public var streetNumber: String
    
    @NSManaged
    public var street: String
    
    @NSManaged
    public var suburb : String
    
    @NSManaged
    public var city: String
    
    @NSManaged
    public var state: String
    
    @NSManaged
    public var country: String
    
    @NSManaged
    public var postCode: String
    
    @NSManaged
    public var isPostalAddress: Bool
    
    //relationship
    @NSManaged
    public var businessEntity: BusinessEntity?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        createdDate = NSDate()
        
        isPostalAddress = false
        state = "NSW"
        country = "Australia"
    }
    
    public class func createEntity() -> Address {
        let ctx: NSManagedObjectContext = DataService.sharedInstance.ctx
        let ed: NSEntityDescription = NSEntityDescription.entityForName("Address", inManagedObjectContext: ctx)
        let newEntity = Address(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newEntity
    }
}