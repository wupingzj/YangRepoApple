//
//  QiuTuiJianTests.swift
//  QiuTuiJianTests
//
//  Created by Ping on 13/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import XCTest
import QiuTuiJian
import UIKit
import CoreData

class QiuTuiJianTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func xtestGetDelegate() {
        println("*** running test testGetDelegate ***")
        
        let app: UIApplication = UIApplication.sharedApplication()
        isObjectNil(Object: app, ObjectName: "app")
        
        let delegate : UIApplicationDelegate = app.delegate!
        isObjectNil(Object: delegate, ObjectName: "delegate")
        
        let appDelegate : AppDelegate = delegate as AppDelegate
        isObjectNil(Object: appDelegate, ObjectName: "appDelegate")
        
        let ctx : NSManagedObjectContext = DataService.sharedInstance.ctx
        isObjectNil(Object: appDelegate, ObjectName: "ctx")
        
    }
    
    func isObjectNil(Object obj:AnyObject?, ObjectName objName:String) {
        if let objReal: AnyObject = obj {
            println("*** \(objName) is NOT nil: \(objReal).")
        } else {
            println("*** \(objName) is nil")
        }
    }
    
    func xtestExample() {
        // YOU SHOULD NEVER test in this way!
        // YOU SHOULD NEVER initialize a AppDelegate object directly
        // because that will initialize the application delegate again, which should be done only once!
        XCTAssert(false, "Fail")
        
        let appDelegate: AppDelegate = AppDelegate();
        //appDelegate.application(UIApplication.sharedApplication(), didFinishLaunchingWithOptions: nil)
    }
    
    func xtestPerformanceExample() {
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
