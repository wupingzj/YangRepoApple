//
//  DataDao.swift
//  QiuTuiJian
//
//  Created by Ping on 31/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

// Import note on error-handling: 
//  Caller must check return NSError before use returned managed object array to make sure the retrieval was successful.
public class DataDao {
    public init() {
    }
    
    public func listEntities(entityName:String)  -> (managedObjects: [NSManagedObject], error: NSError?) {
        return listEntities(entityName, fault:false, sortByKey: "number", ascending: false, fetchBatchSize:20)
    }
    
    public func listEntities(entityName:String, fault:Bool?, sortByKey:String?, ascending:Bool?, fetchBatchSize:Int?) -> (managedObjects: [NSManagedObject], error: NSError?) {
        
        println("**** Will retrieve all entities")
        
        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        //let fetchRequest = NSFetchRequest()
        //let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: ctx)
        //fetchRequest.entity = mobilePhoneED
        
        
        // Set faulting behavior
        if (fault != nil) {
            fetchRequest.returnsObjectsAsFaults = false
        } else {
            // defaul to disable faulting
            // otherwise, you would see data = {fault} if you don't access the fields
            fetchRequest.returnsObjectsAsFaults = false
        }
        
        //fetchRequest.includesPropertyValues = true
        
        // Set the batch size
        if (fetchBatchSize != nil) {
            fetchRequest.fetchBatchSize = fetchBatchSize!
        }
        
        // Set the sort key
        if (sortByKey != nil && ascending != nil) {
            let sortDescriptor = NSSortDescriptor(key: sortByKey, ascending: ascending!)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = [sortDescriptor]
        }

        var error: NSError? = nil
        // To make the class downcast possible, the MobilePhone entity must be mapped to QiuTuiJianTests.MobilePhone in the data model
        // I.E., the model class in Test Target
        //var mobilePhones: MobilePhone[] = ctx.executeFetchRequest(fetchRequest, error: &error) as MobilePhone[]
        var managedObjects: [NSManagedObject] = ctx.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]
        
        if let actualError = error {
            println("An Error Occurred: \(actualError)")
        }
        
        if (error != nil) {
            // log error
            println("Failed to get all \(entityName)s. Unresolved error \(error), \(error!.description)")
        }
        
        return (managedObjects, error)
    }
    
    
    
//    public func createEntity(managedObject:NSManagedObject) -> NSError? {
//        let dataService: DataService = DataService.sharedInstance
//        let ctx: NSManagedObjectContext = dataService.ctx
//
//        let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
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
//        
//        
//        
//        var error: NSError? = nil
//        if ctx != nil {
//            if ctx.hasChanges && !ctx.save(&error) {
//                if let err = error {
//                    println("Error occurred while saving data: \(err) , \(err.userInfo)")
//                } else {
//                    println("Saved data")
//                }
//            }
//        }
//        
//        return error
//    }
    

    // Caller must check the returned NSError to make sure no failure with save
    public func saveContext() -> NSError? {
        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        
        var error: NSError? = nil
        if (ctx != nil && ctx.hasChanges) {
            if !ctx.save(&error) {
                if let err = error {
                    println("Error occurred while saving data: \(err) , \(err.userInfo)")
                } else {
                    // This line should be unreachable
                    println("Saved data")
                }
            } else {
                println("Successfully saved data.")
            }
        }

        return error
    }
}