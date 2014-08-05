//
//  BusinessEntityTest.swift
//  QiuTuiJian
//
//  Created by Ping on 5/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//


import XCTest
import QiuTuiJian
import CoreData

class BusinessEntityTest: XCTestCase {
    func testListEntities() {
        var dataDao: DataDao = DataDao()

        let (managedObjects, error) = dataDao.listEntities("BusinessEntity", fault:false, sortByKey: "name", ascending: false, fetchBatchSize:20)
        
        if (error != nil) {
            println("Failed to get all busines entities. Unresolved error \(error), \(error!.description)")
        } else {
            println("There are totally \(managedObjects.count) business entities in store.")
            
            // cast to business entities
            let businessEntities: [BusinessEntity] = managedObjects as [BusinessEntity]
            for (index, businessEntity) in enumerate(businessEntities) {
                println("business entity[\(index)]: \(businessEntity)")
            }
        }
        
        XCTAssertNil(error, "Failed to get all business entities")
    }
    
    func xtestCreateEntity() {
        let dataDao: DataDao = DataDao()
        
        let newBusinessEntity: BusinessEntity = BusinessEntity.createEntity()
        //newMobilePhone.setValue("65", forKey: "countryCode")
        newBusinessEntity.name = "Solicitor Master005"
        //newBusinessEntity.uuid="uuid000000003"
        let uuid: NSUUID = NSUUID.UUID()
        newBusinessEntity.uuid = uuid.UUIDString
        
        
        var error: NSError? = dataDao.saveContext()
        if let err = error {
            println("Failed to save data context. \(err.userInfo)")
        }
        
        XCTAssert(true, "Failed to create a new mobile phone")
    }
}
