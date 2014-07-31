//
//  DataDaoTests.swift
//  QiuTuiJian
//
//  Created by Ping on 31/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import XCTest

class DataDaoTests: XCTestCase {

    
    func testDataDao() {
        var dataDao: DataDao = DataDao()
        dataDao.listPersistenceStore();
        XCTAssert(true, "Pass")
    }
    
    func testAccessClass() {
        
        
    }
}
