//
//  SeekTableVC.swift
//  QiuTuiJian
//
//  Created by Ping on 6/08/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit
import CoreData

public class SeekTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    var dataService:DataService = DataService.sharedInstance
    
    var ctx: NSManagedObjectContext? = nil
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.ctx = dataService.ctx
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    // -------------------- Copied from TryMasterDetails template project ---------------
    
    // #pragma mark - Segues
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("****** prepareForSegue ******")
        
        if segue.identifier == "showBusinessEntityDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            println("indexPath = \(indexPath)")
            if (indexPath == nil) {
                println("*** ERROR: application will crash... MUST SELECT A business entity to proceed...***")
            }
            
            let businessEntity:BusinessEntity = self.fetchedResultsController.objectAtIndexPath(indexPath) as BusinessEntity
            (segue.destinationViewController as BusinessEntityDetailVC).businessEntity = businessEntity
        } else {
            println("*** ERROR: Unrecongnized segue name in SeekTableVC.prepareForSegue ***")
        }
    }
    
    override public func tableView(tableView: UITableView!, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath!) {
        //super.tableView(tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
        
        println("*** Tapped \(indexPath)")
        
//        [self performSegueWithIdentifier: @"EditUser" sender: [tableView cellForRowAtIndexPath: indexPath]];
    }
    
    
    // #pragma mark - Table View
    
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections.count
    }
    
    // Customize the number of rows in the table view.
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections[section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    // Customize the appearance of table view cells.
    public func configureCell(cell:UITableViewCell, atIndexPath indexPath:NSIndexPath) {
    
        // Configure the cell to show the book's title
        let businessEntity:BusinessEntity = self.fetchedResultsController.objectAtIndexPath(indexPath) as BusinessEntity
        cell.textLabel.text = businessEntity.name
    }
    
    // second implemenation of configureCell - to be deleted
    private func configureCellV2(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
        cell.textLabel.text = object.valueForKey("timeStamp").description
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessEntityCell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override public func tableView(tableView: UITableView, titleForHeaderInSection sectionIdx:NSInteger) -> String {
        
        let section:NSFetchedResultsSectionInfo = self.fetchedResultsController.sections[sectionIdx] as NSFetchedResultsSectionInfo
        
        return section.name!
    }
    
    override public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject)
            
            var error: NSError? = nil
            if !context.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                println("Unresolved error \(error), \(error!.description)")
                abort()
            }
        }
    }
    
    // #pragma mark - Fetched results controller
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("BusinessEntity", inManagedObjectContext: self.ctx)
        fetchRequest.entity = entity
        println("************* BusinessEntity entity class name=\(entity.managedObjectClassName)")
        
        // Set the batch size to a suitable number.
        // @TODO how many categories to show? Consider performance
        fetchRequest.fetchBatchSize = 50
        
        // Edit the sort key as appropriate.
        let sortByCategory = NSSortDescriptor(key: "category", ascending: true)
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortByCategory, sortByName]
        
        fetchRequest.sortDescriptors = sortDescriptors
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.ctx, sectionNameKeyPath: "category", cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        var error: NSError? = nil
        if !_fetchedResultsController!.performFetch(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            println("Unresolved error \(error), \(error!.description)")
            abort()
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    public func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case NSFetchedResultsChangeType.Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            // Move
            // Update
            // @TODO please handle move and update events
            println("****** section is being changed. Please handle it.")
            return
        }
    }
    
    public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case NSFetchedResultsChangeType.Delete:
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case NSFetchedResultsChangeType.Update:
            self.configureCell(tableView.cellForRowAtIndexPath(indexPath), atIndexPath: indexPath)
        case NSFetchedResultsChangeType.Move:
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    public func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    /*
    // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    // In the simplest, most efficient, case, reload the table view.
    self.tableView.reloadData()
    }
    */
}

