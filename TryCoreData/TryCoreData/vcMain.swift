//
//  vcMain.swift
//  TryCoreData
//
//  Created by Ping on 11/07/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit
import CoreData

class vcMain: UIViewController {
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    
    @IBAction func btnSave() {
        //println("Save button pressed \(txtUsername.text)")
        var appDel : AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        newUser.setValue(txtUsername.text, forKey: "username")
        newUser.setValue(txtPassword.text, forKey: "password")

        // TODO - error handling
        context.save(nil)
        
        println(newUser)
        println("New user saved")
        
    }
    
    @IBAction func btnLoad() {
        //println("Load button pressed \(txtPassword.text)")
        var appDel : AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", txtUsername.text)
        
        //        context.deleteObject(<#object: NSManagedObject?#>)
        // TODO -- error handling
        var results: NSArray = context.executeFetchRequest(request, error: nil)
        println("Totally \(results.count) records found")
        if (results.count > 0) {
            var result = results[0] as NSManagedObject
            txtUsername.text = result.valueForKey("username") as String
            txtPassword.text = result.valueForKey("password") as String
            
//            for result in results {
//                println(result)
//            }
        } else {
            // We say potential error because we didn't do error-handling
          println("No user found. Potential Error.")
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

}
