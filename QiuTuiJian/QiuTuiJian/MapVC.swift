//
//  MapVC.swift
//  QiuTuiJian
//
//  Created by Ping on 20/09/2014.
//  Copyright (c) 2014 Yang Ltd. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self

        checkNetwork()
        showLocationOnMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func checkNetwork() {
        // TODO check network
    }
    
    // show specified location on map
    private func showLocationOnMap() {
        mapView.showsUserLocation = true
        
//        ref: https://www.youtube.com/watch?v=uB100xVS_Yc

//        Killara
        var latitude: CLLocationDegrees = -33.764522
        var longtitude: CLLocationDegrees = 151.160827
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)

        var latitudeDelta: CLLocationDegrees = 0.01
        var longitudeDelta: CLLocationDegrees = 0.01
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        
        var zoomRegion: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(zoomRegion, animated: true)

        // annotate the location
        var annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Killara railway station"
        annotation.subtitle = "A lovely railway station!"
    }
    
    // show user's current location
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        mapView.showsUserLocation = true
        
        let userLocation: CLLocationCoordinate2D = userLocation.coordinate
        let zoomRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation, 2500, 2500)
        
        mapView.setRegion(zoomRegion, animated: true)
        
        // annotate the location
        var annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = userLocation
        annotation.title = "You are here!"
        annotation.subtitle = "Have fun!"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
