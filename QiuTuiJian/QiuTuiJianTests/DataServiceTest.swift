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

//    func xtestGetDataServiceSingleton() {
//        let dataService:QiutuiJian.DataService = QiutuiJian.DataService.sharedInstance
//        XCTAssertNotNil(dataService, "DataService is nil")
//        XCTAssert(true, "This is FAILURE message")
//    }
//    
//    func XtestCreateTestData() {
//        println("********** testCreateTestData starting... ***********")
//
//        let dataService: DataService = DataService.sharedInstance
//        let ctx: NSManagedObjectContext = dataService.ctx
//        XCTAssertNotNil(ctx, "ManagedObjectContext ctx is nil")
//        
//        //self.insertNewObject(ctx)
//    }
    
//    func insertNewObject(ctx: NSManagedObjectContext) {
//        let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
////        let aMobilePhone = NSEntityDescription.insertNewObjectForEntityForName(mobilePhoneED.name, inManagedObjectContext: ctx) as NSManagedObject
////        println("mobilePhoneED.name is \(mobilePhoneED.name)")
////        println("mobilePhoneED.managedObjectClassName is \(mobilePhoneED.managedObjectClassName)")
//        
//        let newMobilePhone = MobilePhone(entity: mobilePhoneED, insertIntoManagedObjectContext: ctx)
//        
//        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//        //newMobilePhone.setValue("65", forKey: "countryCode")
//        newMobilePhone.initData()
//        //newMobilePhone.countryCode = "64"
//        //newMobilePhone.areaCode="4"
//        newMobilePhone.number="00000002"
//        newMobilePhone.phoneModel="iPhone 4S"
////        println("************* MobilePhone =\(newMobilePhone.entity)")
//        println("************* MobilePhone =\(newMobilePhone)")
//        
//        // Save the context.
//        var error: NSError? = nil
//        if !ctx.save(&error) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            println("Unresolved error \(error), \(error!.description)")
//            //abort()
//            
//            XCTAssertNotNil(false, "Failed to save managed object context")
//        } else {
//            println("********** SUCCESSFULLY SAVED the managed object context")
//        }
//    }
    
//    func XtestGetMobilePhone() {
//        let dataService: DataService = DataService.sharedInstance
//        let ctx: NSManagedObjectContext = dataService.ctx
//        XCTAssertNotNil(ctx, "ManagedObjectContext ctx is nil")
//        
//        let fetchRequest = NSFetchRequest(entityName: "MobilePhone")
//        //let fetchRequest = NSFetchRequest()
//        //let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
//        //fetchRequest.entity = mobilePhoneED
//        
//        
//        // disable faulting
//        // otherwise, you would see data = {fault} if you don't access the fields
//        fetchRequest.returnsObjectsAsFaults = false
//        //fetchRequest.includesPropertyValues = true
//        
//        // Set the batch size
//        fetchRequest.fetchBatchSize = 20
//        
//        // Set the sort key
//        let sortDescriptor = NSSortDescriptor(key: "number", ascending: false)
//        let sortDescriptors = [sortDescriptor]
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
////        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ctx, sectionNameKeyPath: nil, cacheName: "Master")
////        
//        var error: NSError? = nil
//        // To make the class downcast possible, the MobilePhone entity must be mapped to QiuTuiJianTests.MobilePhone in the data model
//        // I.E., the model class in Test Target
//        var mobilePhones: [MobilePhone] = ctx.executeFetchRequest(fetchRequest, error: &error) as [MobilePhone]
//        //var mobilePhones: AnyObject[] = ctx.executeFetchRequest(fetchRequest, error: &error)
//        
//        println("************** error= \(error)")
//        if (error != nil) {
//            println("Unresolved error \(error), \(error!.description)")
//            
//            XCTAssertNotNil(false, "Failed to save managed object context")
//        } else {
//            println("There are totally \(mobilePhones.count) mobile phones in store.")
//            
//            var mobilePhone: MobilePhone? = nil
//            for mobilePhone in mobilePhones {
//                println("mobile phone: \(mobilePhone) ")
//            }
//        }
//        
//        
//        
//        // narrow the fetch to these two properties
////        fetchRequest.propertiesToFetch = [NSArray arrayWithObjects:@"location", @"date", nil];
////        [fetchRequest setResultType:NSDictionaryResultType];
////        
//        // before adding the earthquake, first check if there's a duplicate in the backing store
////        NSError *error = nil;
////        Earthquake *earthquake = nil;
////        for (earthquake in earthquakes) {
////            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"location = %@ AND date = %@", earthquake.location, earthquake.date];
////            
////            NSArray *fetchedItems = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
////            if (fetchedItems.count == 0) {
////                // we found no duplicate earthquakes, so insert this new one
////                [self.managedObjectContext insertObject:earthquake];
////            }
////        }
//    }
}
