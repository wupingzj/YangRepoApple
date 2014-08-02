//
//  AppDelegate.swift
//  QiuTuiJian
//
//  Created by Ping on 13/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
    public init() {
        
    }
                            
    public var window: UIWindow?
    var dataService:DataService = DataService.sharedInstance

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        println("I am going to start up the application")
        
        let tabBarController = self.window!.rootViewController as UITabBarController
        let controllers = tabBarController.childViewControllers
        let controller = controllers[0] as FavoriteTableVC
        //controller.managedObjectContext = dataService.managedObjectContext
        
        return true
    }

    public func applicationWillResignActive(application: UIApplication) {
        saveContext()
    }

    public func applicationDidEnterBackground(application: UIApplication) {
        saveContext()
    }
   
    public func applicationWillTerminate(application: UIApplication) {
        saveContext()
    }
    
    func saveContext() {
        var error: NSError? = nil
        let ctx = dataService.ctx
        if ctx != nil {
            if ctx.hasChanges && !ctx.save(&error) {
                //abort()
                
                if let err = error {
                    println("Error occurred while saving data: \(err) , \(err.userInfo)")
                } else {
                    println("Saved data")
                }
                
                println("Error occurred while saving data: \(error!), \(error!.userInfo) ")
                
                println("Error occurred while saving data: \(error)")
            }
        }
    }
}

