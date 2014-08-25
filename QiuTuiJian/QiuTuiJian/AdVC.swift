//
//  AdVC.swift
//  QiuTuiJian
//
//  Created by Ping on 21/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit

class AdVC: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var contentView: UIView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.layoutIfNeeded()
        self.scrollView.contentSize = self.contentView.bounds.size
    }

    @IBAction func createTestData(sender: AnyObject) {
        testCreateEntity()
    }
    
    func testCreateEntity() {
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
}
