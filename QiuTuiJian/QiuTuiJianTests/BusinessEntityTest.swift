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
        self.createNewEntity(category1, name: "Kai Wang")
        self.createNewEntity(category1, name: "Vivian")
        self.createNewEntity(category1, name: "Jack Xu")

        let category2 : String = "Solicitor"
        self.createNewEntity(category2, name: "Albert Ma")
        self.createNewEntity(category2, name: "Teresa")
        
        let category3 : String = "Home Mover"
        self.createNewEntity(category3, name: "老刘搬家")
        self.createNewEntity(category3, name: "东北搬家")
        self.createNewEntity(category3, name: "快捷搬家")
        
        var error: NSError? = dataDao.saveContext()
        if let err = error {
            println("Failed to save data context. \(err.userInfo)")
        }
        
        XCTAssert(true, "Failed to create new BusinessEntity s")
    }
    
    private func createNewEntity(category:String, name: String) -> BusinessEntity{
        let newBusinessEntity: BusinessEntity = BusinessEntity.createEntity()
        
        newBusinessEntity.category = category
        newBusinessEntity.name = name
        
        //automatically generate uuid
        newBusinessEntity.uuid = NSUUID.UUID().UUIDString
        
        //newBusinessEntity.setValue("65", forKey: "countryCode")
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
