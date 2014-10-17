//
//  MapVC.swift
//  QiuTuiJian
//
//  Created by Ping on 20/09/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverControllerDelegate {

    @IBOutlet var mapView: MKMapView!
    var businessEntity: BusinessEntity?
    
    private var locationManager: CLLocationManager? = CLLocationManager()
    private var popover: UIPopoverController?
    private var geocoder = CLGeocoder()
    private var mapInfo = MapInfo.ShowBusinessEntity

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        showBusinessEntityOnMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func startSignificantChangeUpdates() {
        if locationManager == nil {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
        }

        self.locationManager!.startMonitoringSignificantLocationChanges()
    }
    
    // show user's current location
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
//        if mapInfo == mapInfo.ShowUser && locationCHANGED {
//            return
//        }
        
        println("*** Show user's current location instead...")
//        if true {
//            return
//        }
        
        println("Show user's current location...")
                
        let userLocation: CLLocationCoordinate2D = userLocation.coordinate
        let zoomRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation, 2500, 2500)
        
        self.mapView.setRegion(zoomRegion, animated: true)
        
        // annotate the location
        var annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = userLocation
//        annotation.title = "You are here!"
        annotation.subtitle = "TODO - show current address"
        
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
        showAlertController(sender)
        //doShowPopover(sender)
    }

    // UIActionSheet and UIAlertView are depreciated for using UIAlertController instead
    private func showAlertController(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Action", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let showUserLocationAction = UIAlertAction(title: "Show my location", style: UIAlertActionStyle.Default,
            handler: { action in
                if self.mapInfo != MapInfo.ShowUser {
                    self.showUserOnMap()
                }
            })
        
        let showBusinessEntityLocationAction = UIAlertAction(title: "Show business location", style: UIAlertActionStyle.Default,
            handler: { action in
                if self.mapInfo != MapInfo.ShowBusinessEntity {
                    self.showBusinessEntityOnMap()
                }
            })
        
        let showBothAction = UIAlertAction(title: "Show both", style: UIAlertActionStyle.Default,
            handler: { action in
                if self.mapInfo != MapInfo.ShowBoth {
                    self.showBothOnMap()
                }
            })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(showUserLocationAction)
        alertController.addAction(showBusinessEntityLocationAction)
        alertController.addAction(showBothAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Search business location and show it on the map
    private func showBusinessEntityOnMap() {
        if let be = self.businessEntity {
            searchAndShowBusinessLocation(be)
        } else {
            showAlertMsg("Sorry", message: "No business entity is selected yet.")
        }
    }
    
    private func showUserOnMap() {
                startSignificantChangeUpdates()
                locationManager!.requestWhenInUseAuthorization()
        // check request succeeded or rejected by user!!!
        

        //searchAndShowBusinessLocation()
        // when success, change status
        self.mapInfo = MapInfo.ShowUser
    }
    
    // show a message with default style and dismiss it after clicking OK Button
    private func showAlertMsg(title: String, message: String) {
        // TODO: UIAlertController requires iOS8
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
            handler: { action in
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // search Apple Map for the location of the business entity and show it when it returns
    private func searchAndShowBusinessLocation(businessEntity: BusinessEntity) {
        checkNetwork()
        
        // var locationToSearch: String = "6 Culworth Ave, Killara, NSW"
        var locationToSearch: String = businessEntity.address.getLocationForSearch()
        println("searching location for \(locationToSearch).")
        
        geocoder.geocodeAddressString(locationToSearch, completionHandler: { (placemarks: [AnyObject]!, error: NSError!) in
            if error != nil {
                self.showAlertMsg("Sorry", message: "Cannot get the location of the business service provider.")
                return
            }
            
            if placemarks != nil && placemarks.count > 0 {
                let top: CLPlacemark = placemarks[0] as CLPlacemark
                let location = top.location
                let addressStr: String = "Address = \(top.subThoroughfare), \(top.thoroughfare), \(top.locality), \(top.location)"
                println("****** Search Result= \(addressStr) ***")
                
                // Take action after the search returns
                // Bear in mind that, location search is asynchronize. It might return before the completion handler is called
                // REF: http://stackoverflow.com/questions/14346516/xcode-ios-clgeocoder-reversegeocodelocation-return-addressstring
                let annotation = self.getAnnotation(location, businessEntity: businessEntity)
                self.showAndAnnotateOnMap(location, annotation: annotation)

                // when success, change status
                self.mapInfo = MapInfo.ShowBusinessEntity
            }
        })
        
        // because location search is asynchronous, there is a good chance that this line is reached 
        // before search is done and the locaton is nil
        // this doesn't necessarily mean the search failed. So don't do anything here!
        return
    }
    
    private func showBothOnMap() {
        // TODO
        // when success, change status
        self.mapInfo = MapInfo.ShowBoth
    }
    
    // Get annotation for business entity at location
    private func getAnnotation(location: CLLocation, businessEntity: BusinessEntity) -> MKPointAnnotation {
        var annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = businessEntity.name
        // annotation.subtitle = "A lovely railway station!"
        return annotation
    }
    
    // zoom to show and annotate on map
    private func showAndAnnotateOnMap(location: CLLocation, annotation: MKPointAnnotation?) {
        // show business on the map
        // "Killara railway station"
        //            var latitude: CLLocationDegrees = -33.764522
        //            var longtitude: CLLocationDegrees = 151.160827
        //var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        
        var latitudeDelta: CLLocationDegrees = 0.01
        var longitudeDelta: CLLocationDegrees = 0.01
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        var zoomRegion: MKCoordinateRegion = MKCoordinateRegionMake(location.coordinate, span)
        self.mapView.setRegion(zoomRegion, animated: true)
        
        // annotate the location
        if (annotation != nil) {
            self.mapView.addAnnotation(annotation)
        }
    }
    
    private func dummy() {
        //localize placemark
        
//        CLPlacemark *placemark;
//
//        NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: placemark.ISOcountryCode forKey: NSLocaleCountryCode]];
//        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//        NSString *country = [usLocale displayNameForKey: NSLocaleIdentifier value: identifier];
    }
    
    private func checkNetwork() {
        // TODO check network
        println("**** TODO - searching Apple Map service on internet...")
    }
    
    private func doShowPopover(sender: UIBarButtonItem) {
        println("Show popover controller")

        let size = CGSizeMake(150, 140)

        if self.popover == nil {
            let mapPopoverVC: MapPopoverVC = MapPopoverVC(style: UITableViewStyle.Plain)
//            let mapPopoverVC: MapPopoverVC = self.storyboard!.instantiateViewControllerWithIdentifier("mapPopoverVC") as MapPopoverVC
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
