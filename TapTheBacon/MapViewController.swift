//
//  MapViewController.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 07/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Parse

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager! = CLLocationManager()
    
    let tecnopucAddress: CLLocation = CLLocation(latitude: -30.060625, longitude: -51.170995)
    
    var pointForWorkplace: MKPointAnnotation!
    
    // THIS SHOULD BE SET FROM THE SERVER
    var locations: NSMutableArray = NSMutableArray()
    
    // THIS WILL BE CREATED FROM VARIABLE locations
    var pointAnnotations: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.getLocationsFromParse()
        
//        self.pointForWorkplace = self.pointAnnotationWithLocation(self.tecnopucAddress, withTitle: "TecnoPuc", withSubtitle: "Here's TecnoPuc")
        
    }
    
    func createMap() {
        for i in 0 ..< self.locations.count{
            let location = self.locations[i] as! CLLocation
            var pointAnnotation = self.pointAnnotationWithLocation(location, withTitle: "Good Location", withSubtitle: "This is a good location")
            mapView.addAnnotation(pointAnnotation)
            self.pointAnnotations.addObject(pointAnnotation)
        }
        
        mapView.showAnnotations( pointAnnotations as [AnyObject], animated: true)
        
        if( pointAnnotations.count != 0 ){
            println("hey")
            // set camera altitude and center coordinate
            mapView.camera.altitude = pow(2, 15)
            mapView.setCenterCoordinate((pointAnnotations.firstObject! as! MKPointAnnotation ).coordinate, animated: true)
        }
    }
    
    internal func getLocationsFromParse() {
        var query = PFQuery(className:"Beacon")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                self.locations.removeAllObjects()
                for object in objects! {
                    var loc = object.objectForKey("Location") as! PFGeoPoint
                    var locright: CLLocation = CLLocation(latitude: loc.latitude, longitude: loc.longitude)

                    self.locations.addObject(locright)
                }
                
                self.createMap()
            } else {
                println(error)
            }

        }
    }
    
    // Creates a point annotatioin for a location
    internal func pointAnnotationWithLocation(location:CLLocation, withTitle title: String, withSubtitle subtitle: String)->MKPointAnnotation{
        var pointForLocation = MKPointAnnotation()
        pointForLocation.coordinate = location.coordinate
        pointForLocation.title = title
        pointForLocation.subtitle = subtitle
        return pointForLocation
    }
    
    
}
