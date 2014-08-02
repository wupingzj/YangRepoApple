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
    func testListMobilePhones1() {
        var dataDao: DataDao = DataDao()
        let result = dataDao.listEntities("MobilePhone")
        //let result = dataDao.listEntities("MobilePhone", fault:false, sortByKey: nil, ascending: false, fetchBatchSize:20)
        println(result)

        XCTAssertNil(result.error, "Failed to get all mobile phonese")
    }
    
    // This test case casts to entity class Mobile Phone
    func testListMobilePhones2() {
        var dataDao: DataDao = DataDao()
        
        let (managedObjects, error) = dataDao.listEntities("MobilePhone")
        //let result = dataDao.listEntities("MobilePhone", fault:false, sortByKey: nil, ascending: false, fetchBatchSize:20)
        if (error != nil) {
            println("Failed to get all mobile phones. Unresolved error \(error), \(error!.description)")
        } else {
            println("There are totally \(managedObjects.count) mobile phones in store.")
            
            // cast to mobile phones
            let mobilePhones: [MobilePhone] = managedObjects as [MobilePhone]
            for (index, mobilePhone) in enumerate(mobilePhones) {
                println("mobile phone[\(index)]: number:\(mobilePhone.number).")
            }
        }
        
        XCTAssertNil(error, "Failed to get all mobile phonese")
    }

}
