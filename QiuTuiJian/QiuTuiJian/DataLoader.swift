//
//  DataLoader.swift
//  QiuTuiJian
//
//  Created by Ping on 5/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import CoreData

class DataLoader {
    func listEntities() {
        let businessEntities: [BusinessEntity] = getBusinessEntityList()
        dispplay(businessEntities)
    }
    
    func getBusinessEntityList() -> [BusinessEntity] {
        var dataDao: DataDao = DataDao()
        
        let (managedObjects, error) = dataDao.listEntities("BusinessEntity", fault:false, sortByKey: "name", ascending: false, fetchBatchSize:20)
        
        if (error != nil) {
            println("****** Failed to get all busines entities. Unresolved error \(error), \(error!.description)")
            
            return [BusinessEntity]()
        } else {
            println("There are totally \(managedObjects.count) business entities in store.")
            
            // cast to business entities
            let businessEntities: [BusinessEntity] = managedObjects as [BusinessEntity]
            return businessEntities
        }
    }
    
    func dispplay(businessEntities: [BusinessEntity]) {
        for (index, businessEntity) in enumerate(businessEntities) {
            println("business entity[\(index)]: \(businessEntity)")
        }
    }
    
    // *** BE CAREFUL ****
    func xdeleteAllEntities() {
        let businessEntities: [BusinessEntity] = getBusinessEntityList()
        dispplay(businessEntities)
        
        let dataDao: DataDao = DataDao()
        let ctx:NSManagedObjectContext = dataDao.getContext()
        //ctx.deletedObjects(businessEntities)
        for (index, businessEntity) in enumerate(businessEntities) {
            ctx.deleteObject(businessEntity)
        }
        
        var error: NSError? = dataDao.saveContext()
        if let err = error {
            println("******* Failed to save data context. \(err.userInfo)")
        }
    }
    
    func createEntity() -> Bool {
        println("Creating busines entities...")
        
        let dataDao: DataDao = DataDao()
        
        let category1 : String = "Mortgage Broker"
        
        let businessEntity1: BusinessEntity = self.createBusinessEntity(category1, phone:"0200000001", name: "Kai Wang", email: "test1@yangahha.com", promotionRank: 0)
        let address1: Address = createAddress("1", street: "Culworth Avenue", suburb: "Killara", city: "Sydney", country: "Australia", state: "NSW", postCode: "2071", isPostalAddress: false)
        businessEntity1.address = address1
        let performance1: Performance = self.createPerformance(1, star: 3)
        businessEntity1.performance = performance1
        
        let businessEntity2: BusinessEntity = self.createBusinessEntity(category1, phone: nil, name: "Vivian", email: "test2@yangahha.com", promotionRank: 0)
        let address2: Address = createAddress("2", street: "Culworth Avenue", suburb: "Killara", city: "Sydney", country: "Australia", state: "NSW", postCode: "2071", isPostalAddress: false)
        businessEntity2.address = address2
        let performance2: Performance = self.createPerformance(1, star: 3)
        businessEntity2.performance = performance2
        
        let businessEntity3: BusinessEntity = self.createBusinessEntity(category1, phone:"0200000003", name: "Jack Xu", email: nil, promotionRank: 1)
        let address3: Address = createAddress("3", street: "Culworth Avenue", suburb: "Killara", city: "Sydney", country: "Australia", state: "NSW", postCode: "2071", isPostalAddress: false)
        businessEntity3.address = address3
        let performance3: Performance = self.createPerformance(1, star: 3)
        businessEntity3.performance = performance3
        
        let category2 : String = "Solicitor"
        
        let businessEntity4: BusinessEntity = self.createBusinessEntity(category2, phone:"0200000004", name: "Albert Ma", email: "test4@yangahha.com", promotionRank: 0)
        let address4: Address = createAddress("4", street: "Culworth Avenue", suburb: "Killara", city: "Sydney", country: "Australia", state: "NSW", postCode: "2071", isPostalAddress: false)
        businessEntity4.address = address4
        let performance4: Performance = self.createPerformance(1, star: 3)
        businessEntity4.performance = performance4
        
        let businessEntity5: BusinessEntity = self.createBusinessEntity(category2, phone:"0200000005", name: "Teresa", email: "test5@yangahha.com", promotionRank: 0)
        let address5: Address = createAddress("5", street: "Culworth Avenue", suburb: "Killara", city: "Sydney", country: "Australia", state: "NSW", postCode: "2071", isPostalAddress: false)
        businessEntity5.address = address5
        let performance5: Performance = self.createPerformance(1, star: 3)
        businessEntity5.performance = performance5
        
        let category3 : String = "Home Mover"
        let businessEntity6: BusinessEntity = self.createBusinessEntity(category3, phone:"0200000006", name: "老刘搬家", email: "test6@yangahha.com", promotionRank: 3)
        let address6: Address = createAddress("6", street: "Culworth Avenue", suburb: "Killara", city: "Sydney", country: "Australia", state: "NSW", postCode: "2071", isPostalAddress: false)
        businessEntity6.address = address6
        let performance6: Performance = self.createPerformance(1, star: 3)
        businessEntity6.performance = performance6
        
        let businessEntity7: BusinessEntity = self.createBusinessEntity(category3, phone:"0200000007", name: "东北搬家", email: "test7@yangahha.com", promotionRank: 0)
        let address7: Address = createAddress("7", street: "Culworth Avenue", suburb: "Killara", city: "Sydney", country: "Australia", state: "NSW", postCode: "2071", isPostalAddress: false)
        businessEntity7.address = address7
        let performance7: Performance = self.createPerformance(1, star: 3)
        businessEntity7.performance = performance7
        
        let businessEntity8: BusinessEntity = self.createBusinessEntity(category3, phone:"0200000008", name: "快捷搬家", email: "test8@yangahha.com", promotionRank: 0)
        let address8: Address = createAddress("8", street: "Culworth Avenue", suburb: "Killara", city: "Sydney", country: "Australia", state: "NSW", postCode: "2071", isPostalAddress: false)
        businessEntity8.address = address8
        let performance8: Performance = self.createPerformance(1, star: 3)
        businessEntity8.performance = performance8
        
        
        var error: NSError? = dataDao.saveContext()
        if let err = error {
            println("**** Failed to save data context. \(err.userInfo)")
            return false
        } else {
            return true
        }
    }
    
    private func createBusinessEntity(category:String, phone: String?, name: String, email: String?, promotionRank: UInt16) -> BusinessEntity{
        let newBusinessEntity: BusinessEntity = BusinessEntity.createEntity()
        
        newBusinessEntity.category = category
        newBusinessEntity.phone = phone
        newBusinessEntity.name = name
        newBusinessEntity.email = email
        newBusinessEntity.promotionRank = promotionRank
        
        return newBusinessEntity
    }
    
    private func createAddress(streetNumber: String, street: String, suburb: String, city: String, country: String, state:String, postCode: String, isPostalAddress: Bool) -> Address {
        let newAddress: Address = Address.createEntity()
        
        newAddress.streetNumber = streetNumber
        newAddress.street = street
        newAddress.suburb = suburb
        newAddress.city = city
        newAddress.state = state
        newAddress.country = country
        newAddress.postCode = postCode
        newAddress.isPostalAddress = isPostalAddress
        
        return newAddress
    }
    
    private func createPerformance(rank:UInt32, star: UInt32) -> Performance {
        let newPerformance: Performance = Performance.createEntity()
        
        newPerformance.rank = rank
        newPerformance.star = star
        
        return newPerformance
    }
    
    private func createPerson() {
        
    }
    private func createBusinessPerson(anonymous: Bool, person: Person) {
        
    }
    
    private func createMobile(number: String, phoneModel: String) -> Mobile {
        let newMobile: Mobile = Mobile.createEntity()
        newMobile.number = number
        
        return newMobile
    }
    
    
    
}
