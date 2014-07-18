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
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        println("I am going to start up the application")
        
        let c = self.window!.rootViewController
        println(c)
        
        let tabBarController = self.window!.rootViewController as UITabBarController
        let controllers = tabBarController.childViewControllers
        let stController = tabBarController.childViewControllers[0]
        if stController is FavoriteTableVC {
            println("stController is a FavoriteTableVC")
        }
        
        if stController is SecondViewController {
            println("stController is a SecondViewController")
        }
        let controller = tabBarController.childViewControllers[0] as FavoriteTableVC
        controller.managedObjectContext = self.managedObjectContext
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        saveContext()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        saveContext()
    }
   
    func applicationWillTerminate(application: UIApplication) {
        saveContext()
    }
    
    func saveContext() {
        var error: NSError? = nil
        let managedObjectContext = self.managedObjectContext
        if managedObjectContext != nil {
            if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
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
    
    // #pragma mark - Core Data stack
    
    // Returns the managed object context for the application.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    var managedObjectContext: NSManagedObjectContext {
        if !_managedObjectContext {
            let coordinator = self.persistentStoreCoordinator
            if coordinator != nil {
                _managedObjectContext = NSManagedObjectContext()
                _managedObjectContext!.persistentStoreCoordinator = coordinator
            }
        }
        return _managedObjectContext!
    }
    var _managedObjectContext: NSManagedObjectContext? = nil
    
    // Returns the managed object model for the application.
    // If the model doesn't already exist, it is created from the application's model.
    var managedObjectModel: NSManagedObjectModel {
        if !_managedObjectModel {
            //let modelURL = NSBundle.mainBundle().URLForResource("QiuTuiJianV0", withExtension: "momd")
            let modelURL = NSBundle.mainBundle().URLForResource("QiuTuiJianModel", withExtension: "momd")
            
            println("model location= \(modelURL)")
            
            _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)
        }

        return _managedObjectModel!
    }
    var _managedObjectModel: NSManagedObjectModel? = nil
    
    // Returns the persistent store coordinator for the application.
    // If the coordinator doesn't already exist, it is created and the application's store added to it.
    var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        if !_persistentStoreCoordinator {
            let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("QiuTuiJianV0.sqlite")
            println(storeURL)
            var error: NSError? = nil
            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            if _persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
                /*
                Replace this implementation with code to handle the error appropriately.
                
                abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                Typical reasons for an error here include:
                * The persistent store is not accessible;
                * The schema for the persistent store is incompatible with current managed object model.
                Check the error message to determine what the actual problem was.
                
                
                If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
                
                If you encounter schema incompatibility errors during development, you can reduce their frequency by:
                * Simply deleting the existing store:
                NSFileManager.defaultManager().removeItemAtURL(storeURL, error: nil)
                
                * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
                [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true}
                
                Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
                
                */
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
        return _persistentStoreCoordinator!
    }
    var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil
    
    // #pragma mark - Application's Documents directory
    
    // Returns the URL to the application's Documents directory.
    var applicationDocumentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as NSURL
    }

    
}

