//
//  AddressTest.swift
//  QiuTuiJian
//
//  Created by Ping on 29/09/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import Foundation
import XCTest
import QiuTuiJian

class AddressTest: XCTestCase {
    func testGetLocationForSearch() {
        println("testing ...")
        let address = Address.createEntity()
        address.streetNumber = "6"
        address.street = "Culworth Avenue"
        address.suburb = "Killara"
        address.city = "Sydney"
        address.country = "Australia"
        address.postCode = "2071"

        println("get an address instance")
        
        println("st no=\(address.getLocationForSearch())")
    }
}