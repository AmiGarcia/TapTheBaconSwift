//
//  GameViewController.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 06/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit
import CoreLocation


// SET THIS LATER
let uuid = NSUUID(UUIDString: "8492E75F-4FD6-469D-B132-043FE94921D8")
let major = CLBeaconMajorValue(10906)
let minor = CLBeaconMinorValue(18216)
let identifier = "beacon.identifier"


class GameViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0 
    
    var beaconsFound: [CLBeacon] = [CLBeacon]()
    let locationManager = CLLocationManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getScore()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        locationManager.stopMonitoringForRegion(beaconRegion)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
//        beaconRegion.notifyEntryStateOnDisplay = true
//        beaconRegion.notifyOnEntry = true
//        beaconRegion.notifyOnExit = true
        
        if( CLLocationManager.authorizationStatus() == .AuthorizedAlways ){
            locationManager.startMonitoringForRegion(beaconRegion)
            //locationManager.requestStateForRegion(beaconRegion)
        }
        
        
    }
    @IBAction func onImageButton(sender: UIButton) {
        
        if( self.beaconsFound.count != 0 ){
            self.score++
            println("adding")
        }else{
            println("hue")
        }
        
        self.scoreLabel.text = String(format: "Score: %d", arguments: [++self.score])
        
        self.saveScore()
    }
    @IBAction func onStoreButton(sender: UIButton) {
        
        self.performSegueWithIdentifier("goToStore", sender: sender)
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
            locationManager.startMonitoringForRegion(beaconRegion)
            println("\(beaconsFound.count)")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        println("hey2")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        
        println("entered region")
        locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        
        println("exiting region")
        self.beaconsFound = [CLBeacon]()
        locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        println("hey")
        
        if (beacons.count > 0) {
            beaconsFound = beacons as! [CLBeacon]
            
            // update stuff based on beacons list
            println("updating beacons")
        }else{
            self.beaconsFound = [CLBeacon]()
        }
    }
    
    func saveScore(){
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let object: NSNumber = userDefaults.objectForKey("score") as? NSNumber {
            userDefaults.setObject(NSNumber(integer: self.score), forKey: "score")
            userDefaults.synchronize()
        }
    }
    
    func getScore(){
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let object: NSNumber = userDefaults.objectForKey("score") as? NSNumber {
            self.score = object.integerValue
            self.scoreLabel.text = String(format: "Score: %ld", arguments: [self.score])
        }
    }

}
