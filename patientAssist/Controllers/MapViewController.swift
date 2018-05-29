//
//  MapViewController.swift
//  patientAssist
//
//  Created by thomas minshull on 2018-05-28.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var locationManager =  (UIApplication.shared.delegate as! AppDelegate).locationManager
    var currentLocation: CLLocation?
    var isLocationConfigured = false
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self as MKMapViewDelegate
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyBest
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        let tempCoordinate = CLLocation(latitude: 49.275691, longitude: -123.114006)
        let intialRegion = MKCoordinateRegionMakeWithDistance(tempCoordinate.coordinate, 1000, 1000)
        mapView.setRegion(intialRegion, animated: true)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
        locationManager.startUpdatingLocation()
      
      let anno = MKPointAnnotation()
      anno.coordinate = CLLocationCoordinate2D(latitude: 49.275691 , longitude: -123.114006)
      anno.title = "Parq Vancouver"
      
      mapView.addAnnotation(anno)

    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        
        if isLocationConfigured == false, CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self),
            let coordinate = currentLocation?.coordinate {
//                let title = "You are Here"
                let radius = 300.0
//
//                let region = CLCircularRegion(center: coordinate,
//                                              radius: radius,
//                                              identifier: title)
//                locationManager.startMonitoring(for: region)
            isLocationConfigured = true
            
            let hospitalCoordiante = CLLocationCoordinate2D(latitude: 49.275691, longitude: -123.114006)
            
            // Adding Clinic
            let needsAssistanceRegion = CLCircularRegion(center: hospitalCoordiante, radius: 1200, identifier: "Hacking Health Clinic")
            needsAssistanceRegion.notifyOnExit = false
            needsAssistanceRegion.notifyOnEntry = true
//            region.notifyOnEntry = true
//            region.notifyOnExit = false
            
            
            let checkedInRegion = CLCircularRegion(center: hospitalCoordiante, radius: 100, identifier: "Hacking Health Clinic")
            checkedInRegion.notifyOnEntry = true
            checkedInRegion.notifyOnExit = false
            
            locationManager.startMonitoring(for: needsAssistanceRegion)
            locationManager.startMonitoring(for: checkedInRegion)
            
            let circle = MKCircle(center: coordinate, radius: radius)
            mapView.add(circle)
        }
        
//        if let cl = currentLocation {
//            
//            mapView.animateToLocation(cl.coordinate)
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = status == .authorizedAlways
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with the following error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        if let circularRegion = region as? CLCircularRegion,
            circularRegion.radius > 50,
            1200 > circularRegion.radius {
            // ToDo display Checkend in  Notification
            let alert = UIAlertController(title: "On our Way", message: "A assitant has been notified that you are on your way, and will be ready to assist you.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            // ToDo display Attendent has been notified that you can
            let alert = UIAlertController(title: "You've Arrived", message: "The hospital staff have been notified that you've arived and begun checking you in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        
    }
}

