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
class DataDao {
    func listEntities(entityName:String!) -> (NSManagedObject[], NSError?) {
        return listEntities(entityName, fault:false, sortByKey: nil, ascending: false, fetchBatchSize: 20)
    }
    
    func listEntities(entityName:String!, fault:Bool?, sortByKey:String?, ascending:Bool?, fetchBatchSize:Int?) -> (NSManagedObject[], NSError?) {
        let dataService: DataService = DataService.sharedInstance
        let ctx: NSManagedObjectContext = dataService.ctx
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        //let fetchRequest = NSFetchRequest()
        //let mobilePhoneED: NSEntityDescription = NSEntityDescription.entityForName("MobilePhone", inManagedObjectContext: ctx)
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
        var managedObjects: NSManagedObject[] = ctx.executeFetchRequest(fetchRequest, error: &error) as NSManagedObject[]
        
        if (error != nil) {
            // log error
            println("Failed to get all \(entityName)s. Unresolved error \(error), \(error.description)")
        }
        
        return (managedObjects, error)
    }
}