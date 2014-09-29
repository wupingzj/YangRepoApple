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
    // To allow easy management, optional fields cannot be nil but can be empty
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
        let ed: NSEntityDescription = NSEntityDescription.entityForName("Address", inManagedObjectContext: ctx)!
        let newEntity = Address(entity: ed, insertIntoManagedObjectContext: ctx)
        
        return newEntity
    }
    
    func getLine1() -> String {
        return streetNumber + " " + street
    }
    
    func getLine2() -> String {
        return suburb
    }
    
    // Get the location string for search with Apple CLGeocoder
    public func getLocationForSearch() -> String {
        // contencat location details with ,
        var location: String = ""
        
        append(&location, string: self.streetNumber)
        append(&location, string: self.street)
        append(&location, string: self.suburb)
        append(&location, string: self.city)
        append(&location, string: self.country)
        append(&location, string: self.postCode)

        return location
    }

    // append string to location
    private func append(inout location: String, string: String) {
        if !string.isEmpty {
            if !location.isEmpty {
                location.extend(",")
            }
            
            location.extend(string)
        }
    }
}