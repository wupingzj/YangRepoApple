//
//  DataServiceTest.swift
//  QiuTuiJian
//
//  Created by Ping on 25/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import XCTest
import QiutuiJian
import CoreData

class DataServiceTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func xtestGetDataServiceSingleton() {
        let dataService:DataService = DataService.sharedInstance
        XCTAssertNotNil(dataService, "DataService is nil")
        XCTAssert(true, "Pass")
    }

    func testCreateTestData() {
        println("********** testCreateTestData starting... ***********")

        let dataService:DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        
        self.insertNewObject("DataServiceTest")
        
        XCTAssertNotNil(ctx, "ManagedObjectContext ctx is nil")
    }
    
    func insertNewObject(sender: AnyObject) {
        println("\(sender) is creating a new mobile phone entity...")
        
        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        //let entity = self.fetchedResultsController.fetchRequest.entity
        let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
        let newMobilePhone = NSEntityDescription.insertNewObjectForEntityForName(mobilePhoneED.name, inManagedObjectContext: ctx) as MobilePhone
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        //newMobilePhone.setValue(NSDate.date(), forKey: "timeStamp")
        newMobilePhone.countryCode = "64"
        newMobilePhone.areaCode="4"
        newMobilePhone.phoneNumber="87654321"
        newMobilePhone.phoneModel="iPhone 4S"
        
        
        // Save the context.
//        var error: NSError? = nil
//        if !ctx.save(&error) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            println("Unresolved error \(error), \(error.userInfo)")
//            abort()
//        }
    }
}
