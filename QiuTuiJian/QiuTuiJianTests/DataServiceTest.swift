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
    
    func failed_testModelClassName() {
        let aMobilePhone: MobilePhone = MobilePhone()
        println("aMobilePhone class name = \(aMobilePhone.entity)")
        println("\(object_getClassName(aMobilePhone))");
        XCTAssert(true, "Pass")
    }

    func testCreateTestData() {
        println("********** testCreateTestData starting... ***********")

        let dataService:DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        
        self.insertNewObject("DataServiceTest")
        
        XCTAssertNotNil(ctx, "ManagedObjectContext ctx is nil")
    }
    
    func insertNewObjectX(sender: AnyObject) {
        println("\(sender) is creating a new BusinessEntity entity...")
        
        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        //let entity = self.fetchedResultsController.fetchRequest.entity
        let businessEntityED: NSEntityDescription = NSEntityDescription.entityForName("BusinessEntity", inManagedObjectContext: ctx)
        
        println("businessEntityED.name is \(businessEntityED.name)")
        println("businessEntityED is \(businessEntityED)")
        println("businessEntityED.managedObjectClassName is \(businessEntityED.managedObjectClassName)")
        let aBusinessEntity = NSEntityDescription.insertNewObjectForEntityForName(businessEntityED.name, inManagedObjectContext: ctx) as NSManagedObject
        
        
//        if (aBusinessEntity is BusinessEntity) {
//            println("aBusinessEntity is a BusinessEntity")
//        } else {
//            println("aBusinessEntity is NOT a BusinessEntity")
//            
//        }
//        
//        let newBusinessEntity = NSEntityDescription.insertNewObjectForEntityForName(businessEntityED.name, inManagedObjectContext: ctx) as BusinessEntity
//        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        //newMobilePhone.setValue(NSDate.date(), forKey: "timeStamp")
        //newBusinessEntity.name = "64"
    }

    
    
    
    
    
    
    
    
    func insertNewObject(sender: AnyObject) {
        println("\(sender) is creating a new mobile phone entity...")
        
        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        //let entity = self.fetchedResultsController.fetchRequest.entity
        let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
        
        println("mobilePhoneED.name is \(mobilePhoneED.name)")
        println("mobilePhoneED is \(mobilePhoneED)")
        println("mobilePhoneED.managedObjectClassName is \(mobilePhoneED.managedObjectClassName)")
//        let aMobilePhone = NSEntityDescription.insertNewObjectForEntityForName(mobilePhoneED.name, inManagedObjectContext: ctx) as NSManagedObject
//        
//        if (aMobilePhone is MobilePhone) {
//            println("aMobilePhone is a MobilePhone")
//        } else {
//            println("aMobilePhone is NOT a MobilePhone")
//            
//        }
        
//        let newMobilePhone = NSEntityDescription.insertNewObjectForEntityForName(mobilePhoneED.name, inManagedObjectContext: ctx) as NSManagedObject
        
        let newMobilePhone = MobilePhone(entity: mobilePhoneED, insertIntoManagedObjectContext: ctx)
        println("************* MobilePhone entity class name=\(newMobilePhone.entity.managedObjectClassName)")
        
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        //newMobilePhone.setValue(NSDate.date(), forKey: "timeStamp")
        newMobilePhone.countryCode = "64"
        newMobilePhone.areaCode="4"
        newMobilePhone.number="87654321"
        newMobilePhone.phoneModel="iPhone 4S"
        
//        newMobilePhone.setValue("64", forKey: "countryCode")
//        newMobilePhone.setValue("4", forKey: "areaCode")
//        newMobilePhone.setValue("87654321", forKey: "phoneNumber")
//        newMobilePhone.setValue("iPhone 4S", forKey: "phoneModel")
        
        
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
