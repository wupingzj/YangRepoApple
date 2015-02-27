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
        println("Creating busines entities...")

        let dataDao: DataDao = DataDao()
        
        let category1 : String = "Mortgage Broker"
        self.createNewEntity(category1, name: "Kai Wang", mobile: "0400000001", email: "test@yangahha.com")
        self.createNewEntity(category1, name: "Vivian", mobile: "0400000002", email: "test@yangahha.com")
        self.createNewEntity(category1, name: "Jack Xu", mobile: "0400000003", email: "test@yangahha.com")

        let category2 : String = "Solicitor"
        self.createNewEntity(category2, name: "Albert Ma", mobile: "0420000001", email: "test@yangahha.com")
        self.createNewEntity(category2, name: "Teresa", mobile: "0420000002", email: "test@yangahha.com")
        
        let category3 : String = "Home Mover"
        self.createNewEntity(category3, name: "老刘搬家", mobile: "0430000001", email: "test@yangahha.com")
        self.createNewEntity(category3, name: "东北搬家", mobile: "0430000002", email: "test@yangahha.com")
        self.createNewEntity(category3, name: "快捷搬家", mobile: "0430000003", email: "test@yangahha.com")
        
        var error: NSError? = dataDao.saveContext()
        if let err = error {
            println("Failed to save data context. \(err.userInfo)")
            
            XCTAssert(false, "Failed to create new BusinessEntity s")
        }
    }
    
    func xtestDeleteAllData() {
        println("Creating more busines entities...")
        
        let dataDao: DataDao = DataDao()
        
        let category1 : String = "Builder"
        self.createNewEntity(category1, name: "Tony Smith", mobile: "0440000001", email: "test@yangahha.com")
        self.createNewEntity(category1, name: "Johnson Fox", mobile: "0440000002", email: "test@yangahha.com")
        
        
        var error: NSError? = dataDao.saveContext()
        if let err = error {
            //The cocoa error 1570 means that mandatory fields are not filled in
            println("Failed to save data context. \(err.userInfo)")
        }
        
        XCTAssert(true, "Failed to create new BusinessEntity s")
    }
    
    private func createNewEntity(category:String, name: String, mobile: String, email: String) -> BusinessEntity{
        let newBusinessEntity: BusinessEntity = BusinessEntity.createEntity()

        newBusinessEntity.category = category
        newBusinessEntity.name = name
        newBusinessEntity.email = email
        
        let newMobile: Mobile = Mobile.createEntity()
        newMobile.number = mobile

        // link BusinessEntity and Mobile
        //newBusinessEntity.mobile = newMobile

        return newBusinessEntity
    }
    
    // *** BE CAREFUL ****
    func xtestDeleteAllEntities() {
        var dataDao: DataDao = DataDao()
        
        let (managedObjects, error) = dataDao.listEntities("BusinessEntity", fault:false, sortByKey: "name", ascending: false, fetchBatchSize:20)
        
        XCTAssertNil(error, "Failed to get all business entities")
        if (error != nil) {
            println("Failed to get all busines entities. Unresolved error \(error), \(error!.description)")
        } else {
            println("There are totally \(managedObjects.count) business entities in store.")
            
            // cast to business entities
            let businessEntities: [BusinessEntity] = managedObjects as [BusinessEntity]
            
            // delete
            let ctx:NSManagedObjectContext = dataDao.getContext()
            //ctx.deletedObjects(businessEntities)
            for (index, businessEntity) in enumerate(businessEntities) {
                ctx.deleteObject(businessEntity)
                println("deleting business entity[\(index)]: \(businessEntity)")
            }
            
            var error: NSError? = dataDao.saveContext()
            if let err = error {
                println("Failed to save data context. \(err.userInfo)")
            }
            
            XCTAssertNil(error, "Failed to delete all business entities")
        }
        
    }

}
