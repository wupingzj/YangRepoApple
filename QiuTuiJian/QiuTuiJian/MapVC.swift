//
//  MapVC.swift
//  QiuTuiJian
//
//  Created by Ping on 20/09/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate {

    @IBOutlet var mapView: MKMapView!
    
    
    private var locationManager: CLLocationManager? = CLLocationManager()
    private var popover: UIPopoverController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
//        self.mapView.showsUserLocation = true
        
//        startSignificantChangeUpdates()
//        locationManager!.requestWhenInUseAuthorization()
        // check request succeeded or rejected by user!!!
        

        checkNetwork()
        showBusinessEntityOnMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func checkNetwork() {
        // TODO check network
    }
    
    private func startSignificantChangeUpdates() {
        if !(locationManager != nil) {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
        }

        self.locationManager!.startMonitoringSignificantLocationChanges()
    }
    
    // show specified location on map
    private func showBusinessEntityOnMap() {
//        Killara
        var latitude: CLLocationDegrees = -33.764522
        var longtitude: CLLocationDegrees = 151.160827
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)

        var latitudeDelta: CLLocationDegrees = 0.01
        var longitudeDelta: CLLocationDegrees = 0.01
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        
        var zoomRegion: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.mapView.setRegion(zoomRegion, animated: true)
        
        // place a mark
        //let placeMark: CLPlacemark =

        // annotate the location
        var annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Killara railway station"
        annotation.subtitle = "A lovely railway station!"
        self.mapView.addAnnotation(annotation)
    }
    
    // show user's current location
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        if true {
            return
        }
        
        println("Show user's current location instead...")
                
        let userLocation: CLLocationCoordinate2D = userLocation.coordinate
        let zoomRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation, 2500, 2500)
        
        self.mapView.setRegion(zoomRegion, animated: true)
        
        // annotate the location
        var annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = userLocation
        annotation.title = "You are here!"
        // annotation.subtitle = "Have fun!"
        
        self.mapView.addAnnotation(annotation)
    }
    
    // Reference
    // Search location : Search bar
    // http://youtu.be/U_sq4XYK8WQ
    // https://www.youtube.com/watch?v=U_sq4XYK8WQ
    
    // CLGeocoder to search places
    
    // https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/MapKit/MapKit.html
    
    // show user location
    // ref: https://www.youtube.com/watch?v=uB100xVS_Yc

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // TODO
    // Save battery. Ref: https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/CoreLocation/CoreLocation.html#//apple_ref/doc/uid/TP40009497-CH2-SW1
    
    //   1. --- when exit MapVC, call locationManager.stopMonitoringSignificantLocationChanges  to save battery power
    
    // Only ask for current user location, when user asks to show Where am I?
    //     From there, steps: 
    //          create locationManager, 
    //          assign delegate, 
    //          startMonitoringSignificantLocationChanges,
    //          self.mapView.showsUserLocation = true
    //          keep updateing user location - didUpdateUserLocation (check timestamp, check significant?)
    
    
    @IBAction func showPopover(sender: UIBarButtonItem) {
        showAlertController2(sender)
    }

    // UIActionSheet and UIAlertView are depreciated for using UIAlertController instead
    private func showAlertController(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "MyTitle", message: "MyMsg", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let showUserLocationAction = UIAlertAction(title: "Show my location", style: UIAlertActionStyle.Default,
            handler: { action in
                println("Clicked showUserLocationAction")
            })
        
        let showBusinessEntityLocationAction = UIAlertAction(title: "Show business location", style: UIAlertActionStyle.Default,
            handler: { action in
                println("Clicked show business location")
            })
        
        alertController.addAction(showUserLocationAction)
        alertController.addAction(showBusinessEntityLocationAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func showAlertController2(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "MyTitle", message: "MyMsg", preferredStyle: UIAlertControllerStyle.Alert)
        let showUserLocationAction = UIAlertAction(title: "Show my location", style: UIAlertActionStyle.Default,
            handler: { action in
                println("Clicked showUserLocationAction")
            })
        
        let showBusinessEntityLocationAction = UIAlertAction(title: "Show business location", style: UIAlertActionStyle.Default,
            handler: { action in
                println("Clicked show business location")
            })
        
        let showBothAction = UIAlertAction(title: "Show both", style: UIAlertActionStyle.Default,
            handler: { action in
                println("Clicked show both")
            })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(showUserLocationAction)
        alertController.addAction(showBusinessEntityLocationAction)
        alertController.addAction(showBothAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func showPopover2(sender: UIBarButtonItem) {
        println("Show popover controller")
        
        if !(popover != nil) {
            let size = CGSizeMake(320, 200)
            
            //let mapPopoverVC: MapPopoverVC = MapPopoverVC()
            let mapPopoverVC: MapPopoverVC = self.storyboard!.instantiateViewControllerWithIdentifier("mapPopoverVC") as MapPopoverVC
            //            let mapPopoverVC: UIViewController = self.storyboard.instantiateViewControllerWithIdentifier("mapPopoverVC2") as UIViewController
            mapPopoverVC.preferredContentSize = size
            
            self.popover = UIPopoverController(contentViewController: mapPopoverVC)
            self.popover!.setPopoverContentSize(size, animated: true)
        }
        
        self.popover!.delegate = self
        self.popover!.presentPopoverFromBarButtonItem(sender, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        
        //        let frame = CGRectMake(20, 20, 100, 100)
        //        self.popover!.presentPopoverFromRect(frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
    }
}
