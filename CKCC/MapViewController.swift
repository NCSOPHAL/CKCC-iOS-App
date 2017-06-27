//
//  MapViewController.swift
//  CKCC
//
//  Created by Bun Leap on 6/19/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign delegate to MapView
        mapView.delegate = self
        
        // Zoom camera to CKCC position
        let ckccCameraPosition = GMSCameraPosition.camera(withLatitude: 11.569045, longitude: 104.888461, zoom: 15.0)
        mapView.animate(to: ckccCameraPosition)
        
        
        // Add marker to CKCC position
        let marker = GMSMarker()
        let ckccPosition = CLLocationCoordinate2D(latitude: 11.569045, longitude: 104.888461)
        marker.position = ckccPosition
        marker.title = "Cambodia-Korea Cooperation Center"
        marker.snippet = "CKCC"
        marker.map = mapView
        
        // Get current location
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = "Cambodia-Korea Cooperation Center"
        marker.snippet = "CKCC"
        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        let location = locations.last!
        let marker = GMSMarker()
        marker.position = location.coordinate
        marker.title = "I'm here"
        marker.map = mapView
        locationManager.stopUpdatingLocation()
    }
    

}
