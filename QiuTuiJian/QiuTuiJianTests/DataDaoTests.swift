//
//  DataDaoTests.swift
//  QiuTuiJian
//
//  Created by Ping on 31/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import XCTest
import QiuTuiJian

class DataDaoTests: XCTestCase {
    
    // This test case handles raw managed objects
    func xtestListMobiles1() {
        var dataDao: DataDao = DataDao()
        let result = dataDao.listEntities("Mobile")
        //let result = dataDao.listEntities("Mobile", fault:false, sortByKey: nil, ascending: false, fetchBatchSize:20)
        println(result)

        XCTAssertNil(result.error, "Failed to get all mobile phonese")
    }
    
    // This test case casts to entity class Mobile Phone
    func xtestListMobiles2() {
        var dataDao: DataDao = DataDao()
        
        //let (managedObjects, error) = dataDao.listEntities("Mobile")
        let (managedObjects, error) = dataDao.listEntities("Mobile", fault:false, sortByKey: nil, ascending: false, fetchBatchSize:20)

        //let result = dataDao.listEntities("Mobile", fault:false, sortByKey: nil, ascending: false, fetchBatchSize:20)
        if (error != nil) {
            println("Failed to get all mobile phones. Unresolved error \(error), \(error!.description)")
        } else {
            println("There are totally \(managedObjects.count) mobile phones in store.")
            
            // cast to mobile phones
            let Mobiles: [Mobile] = managedObjects as [Mobile]
            for (index, Mobile) in enumerate(Mobiles) {
                println("mobile phone[\(index)]: number:\(Mobile.number).")
            }
        }
        
        XCTAssertNil(error, "Failed to get all mobile phones")
    }
    
    func xtestCreateMobile() {
        let dataDao: DataDao = DataDao()
        
        let newMobile: Mobile = Mobile.createEntity()
        //newMobile.setValue("65", forKey: "countryCode")
        newMobile.number="00000010"
        newMobile.phoneModel="iPhone 5S"
        
        var error: NSError? = dataDao.saveContext()
        if let err = error {
            println("Failed to save data context. \(err.userInfo)")
        }
        
        XCTAssert(true, "Failed to create a new mobile phone")
    }
    
    func xtestNothing() {
        println("Finished testing.")
        XCTAssert(true, "Failed to run an empty test")
    }

}
