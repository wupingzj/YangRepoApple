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
        XCTAssert(true, "This is FAILURE message")
    }
    
    func XtestCreateTestData() {
        println("********** testCreateTestData starting... ***********")

        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        XCTAssertNotNil(ctx, "ManagedObjectContext ctx is nil")
        
        self.insertNewObject(ctx)
    }
    
    func insertNewObject(ctx: NSManagedObjectContext) {
        let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
//        let aMobilePhone = NSEntityDescription.insertNewObjectForEntityForName(mobilePhoneED.name, inManagedObjectContext: ctx) as NSManagedObject
//        println("mobilePhoneED.name is \(mobilePhoneED.name)")
//        println("mobilePhoneED.managedObjectClassName is \(mobilePhoneED.managedObjectClassName)")
        
        let newMobilePhone = MobilePhone(entity: mobilePhoneED, insertIntoManagedObjectContext: ctx)
        
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        //newMobilePhone.setValue("65", forKey: "countryCode")
        newMobilePhone.countryCode = "64"
        newMobilePhone.areaCode="4"
        newMobilePhone.number="87654321"
        newMobilePhone.phoneModel="iPhone 4S"
//        println("************* MobilePhone =\(newMobilePhone.entity)")
        println("************* MobilePhone =\(newMobilePhone)")
        
        // Save the context.
        var error: NSError? = nil
        if !ctx.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            println("Unresolved error \(error), \(error.description)")
            //abort()
            
            XCTAssertNotNil(false, "Failed to save managed object context")
        } else {
            println("********** SUCCESSFULLY SAVED the managed object context")
        }
    }
    
    func testGetMobilePhone() {
        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        XCTAssertNotNil(ctx, "ManagedObjectContext ctx is nil")
        
        //let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        //let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
        //fetchRequest.entity = mobilePhoneED
        let fetchRequest = NSFetchRequest(entityName: "MobilePhone")
        
        // disable faulting
        fetchRequest.returnsObjectsAsFaults = false
        
        // Set the batch size
        fetchRequest.fetchBatchSize = 20
        
        // Set the sort key
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = [sortDescriptor]
        
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ctx, sectionNameKeyPath: nil, cacheName: "Master")
//        
        var error: NSError? = nil
        //var mobilePhones: MobilePhone[] = ctx.executeFetchRequest(fetchRequest, error: &error) as MobilePhone[]
        var mobilePhones: AnyObject[] = ctx.executeFetchRequest(fetchRequest, error: &error)
        
        println("************** error= \(error)")
        if (error != nil) {
            println("Unresolved error \(error), \(error.description)")
            
            XCTAssertNotNil(false, "Failed to save managed object context")
        } else {
            println("********** SUCCESSFULLY SAVED the managed object context")
            println("There are totally \(mobilePhones.count) mobile phones in store.")
            var a = mobilePhones[0]
            if (a is MobilePhone) {
                println("The stored is a mobile phone object")
            } else {
                println("The stored is NOT a mobile phone object")
            }
            
            if (a is NSManagedObject) {
                println("The stored is a NSManagedObject")
            } else {
                println("The stored is NOT a NSManagedObject")
            }
            
            println("There are totally \(mobilePhones[0]) mobile phones in store.")
            
            var mobilePhone: MobilePhone? = nil
//            for (mobilePhone in mobilePhones) {
//                
//            }
        }
        
        
        
        // narrow the fetch to these two properties
//        fetchRequest.propertiesToFetch = [NSArray arrayWithObjects:@"location", @"date", nil];
//        [fetchRequest setResultType:NSDictionaryResultType];
//        
        // before adding the earthquake, first check if there's a duplicate in the backing store
//        NSError *error = nil;
//        Earthquake *earthquake = nil;
//        for (earthquake in earthquakes) {
//            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"location = %@ AND date = %@", earthquake.location, earthquake.date];
//            
//            NSArray *fetchedItems = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//            if (fetchedItems.count == 0) {
//                // we found no duplicate earthquakes, so insert this new one
//                [self.managedObjectContext insertObject:earthquake];
//            }
//        }
    }
}
