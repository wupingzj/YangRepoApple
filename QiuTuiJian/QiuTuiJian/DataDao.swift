//
//  DataDao.swift
//  QiuTuiJian
//
//  Created by Ping on 31/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import CoreData

class DataDao {
    func listPersistenceStore() {
        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        
        let fetchRequest = NSFetchRequest(entityName: "MobilePhone")
        //let fetchRequest = NSFetchRequest()
        //let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
        //fetchRequest.entity = mobilePhoneED
        
        
        // disable faulting
        // otherwise, you would see data = {fault} if you don't access the fields
        fetchRequest.returnsObjectsAsFaults = false
        //fetchRequest.includesPropertyValues = true
        
        // Set the batch size
        fetchRequest.fetchBatchSize = 20
        
        // Set the sort key
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ctx, sectionNameKeyPath: nil, cacheName: "Master")
        //
        var error: NSError? = nil
        // To make the class downcast possible, the MobilePhone entity must be mapped to QiuTuiJianTests.MobilePhone in the data model
        // I.E., the model class in Test Target
        var mobilePhones: MobilePhone[] = ctx.executeFetchRequest(fetchRequest, error: &error) as MobilePhone[]
        //var mobilePhones: AnyObject[] = ctx.executeFetchRequest(fetchRequest, error: &error)
        
        println("************** error= \(error)")
        if (error != nil) {
            println("Unresolved error \(error), \(error.description)")
            
        } else {
            println("There are totally \(mobilePhones.count) mobile phones in store.")
            var a = mobilePhones[0]
            //            if (a is MobilePhone) {
            //                println("The stored is a mobile phone object")
            //            } else {
            //                println("The stored is NOT a mobile phone object")
            //            }
            //
            //            if (a is NSManagedObject) {
            //                println("The stored is a NSManagedObject")
            //            } else {
            //                println("The stored is NOT a NSManagedObject")
            //            }
            //
            
            //var obj :AnyObject? = nil
            //            for obj : AnyObject in mobilePhones {
            //                println("mobile phone: \(obj) ")
            //            }
            
            
            var mobilePhone: MobilePhone? = nil
            for mobilePhone in mobilePhones {
                println("mobile phone: \(mobilePhone) ")
            }
        }
    }
}