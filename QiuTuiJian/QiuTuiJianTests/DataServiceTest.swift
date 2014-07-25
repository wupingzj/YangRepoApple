//
//  DataServiceTest.swift
//  QiuTuiJian
//
//  Created by Ping on 25/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import XCTest
import QiutuiJian

class DataServiceTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetDataServiceSingleton() {
        let dataService:DataService = DataService.sharedInstance
        
        XCTAssertNotNil(dataService, "Pass")
        
        XCTAssert(true, "Pass")
        
        println("********** testGetDataServiceSingleton passed ***********")
    }

}
