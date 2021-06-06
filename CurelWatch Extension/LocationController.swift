//
//  LocationController.swift
//  CurelWatch Extension
//
//  Created by HAYATOYAMAMOTo on 2021/06/05.
//

import WatchKit
import CoreLocation

var currentLocation = CLLocation()
var lat:Double = 0.0
var long:Double = 0.0

class LocationController: WKInterfaceController {
    
    override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    //WatchConnector.shared.listenToMessageBlock({ (message) in

    //self.lat = message["lat"] as! Double
    //self.long = message["long"] as! Double
    //print(self.lat)
    //print(self.long)

    //self.currentLocation = CLLocation(latitude: self.lat as! CLLocationDegrees, longitude: self.long as! CLLocationDegrees)

    //let mylocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude)
    //let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    //let region = MKCoordinateRegion(center: mylocation, span: span)
    //self.mapView.setRegion(region)
    //self.mapView.addAnnotation(mylocation, with: .red)
    //}, withIdentifier: "sendCurrentLocation")
    }
    
    //override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    //    self.lblLatitude.setText("\(self.lat)")
    //    self.lbllongitude.setText("\(self.long)")
    //}
    
}
