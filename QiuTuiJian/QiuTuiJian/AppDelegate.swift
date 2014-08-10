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

        // The following code heavily depends on the storyboard defination
        // **********************************************************
        let tabBarController = self.window!.rootViewController as UITabBarController
        let tabbedControllers = tabBarController.childViewControllers
        let favoriteNavigationController: UINavigationController = tabbedControllers[0] as UINavigationController
        let controller: FavoriteTableVC = favoriteNavigationController.childViewControllers[0] as FavoriteTableVC
        // **********************************************************
        
//        outdated. Just to show how to 
//              - print class name using object_getClassName
//              - check class type
//        
//        if (controllers[0] is FavoriteTableVC) {
//            println("The first controller is a FavoriteTableVC")
//        } else {
//            println("The first controller is NOT a FavoriteTableVC. It is a \(object_getClassName(a)).")
//        }
        
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
            if ctx.hasChanges {
                println("*** ctx has been changed*** ")
            }
            
            
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

