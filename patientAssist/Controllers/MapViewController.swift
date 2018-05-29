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
    var locationManager =  CLLocationManager()
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLLocationAccuracyBest
        
        mapView.delegate = self as MKMapViewDelegate
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        if let currentLocation = locationManager.location,
            CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let title = "You are Here"
            let coordinate = currentLocation.coordinate
            let radius = 300.0
            
            let region = CLCircularRegion(center: coordinate,
                                          radius: radius,
                                          identifier: title)
            locationManager.startMonitoring(for: region)
            
           
            
            let hospitalCoordiante = CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.03660000000002)
            
            // Adding Clinic
            let needsAssistanceRegion = CLCircularRegion(center: hospitalCoordiante, radius: 10, identifier: "Hacking Health Clinic")
            region.notifyOnEntry = true
            region.notifyOnExit = false
           
            
            let checkedInRegion = CLCircularRegion(center: hospitalCoordiante, radius: 2, identifier: "Hacking Health Clinic")
            
            locationManager.startMonitoring(for: needsAssistanceRegion)
            locationManager.startMonitoring(for: checkedInRegion)
            
            
            // add anotation for hospital
//            let restaurantAnnotation = MKPointAnnotation()
//            restaurantAnnotation.coordinate = coordinate;
//            restaurantAnnotation.title = "\(title)";
//            mapView.addAnnotation(restaurantAnnotation)
            
            
            let circle = MKCircle(center: coordinate, radius: radius)
            mapView.add(circle)

        } else {
            print("failed to fetch current location")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: CLLocationManagerDelegate {
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
            circularRegion.radius <= 3 {
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

