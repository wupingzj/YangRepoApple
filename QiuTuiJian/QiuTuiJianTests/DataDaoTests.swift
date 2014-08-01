//
//  DataDaoTests.swift
//  QiuTuiJian
//
//  Created by Ping on 31/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import XCTest

class DataDaoTests: XCTestCase {
    func testListMobilePhones() {
        var dataDao: DataDao = DataDao()

        let (mobilePhones, error) = dataDao.listEntities("MobilePhone")
        if (error != nil) {
            println("Failed to get all mobile phones. Unresolved error \(error), \(error.description)")
        } else {
            println("There are totally \(mobilePhones.count) mobile phones in store.")
            
            for (index, mobilePhone) in enumerate(mobilePhones) {
                println("mobile phone[\(index)]: \(mobilePhone).")
            }
        }
        
        XCTAssertNil(error, "Failed to get all mobile phonese")
    }
}
