//
//  GameViewController.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 06/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit
import CoreLocation
import Parse


// SET THIS LATER
let uuid = NSUUID(UUIDString: "8492E75F-4FD6-469D-B132-043FE94921D8")
let major = CLBeaconMajorValue(10906)
let minor = CLBeaconMinorValue(18216)
let identifier = "beacon.identifier"


class GameViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var baconButtom: UIButton!
    
    var score: Int = 0
    var multiplier: Int = 0
    var autoclicks: Int = 0
    var timer: NSTimer!
    
    var beaconsFound: [CLBeacon] = [CLBeacon]()
    let locationManager = CLLocationManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
    
    var currentLocation:CLLocation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getScore()
        self.multiplier = self.getMultiplierValue()
        self.autoclicks = self.getAutoClicks()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("onTimerEvent"), userInfo: nil, repeats: true)
        
    }
    
    func onTimerEvent() {
//        if( self.beaconsFound.count != 0 ){
//            self.score += self.multiplier
//            println("adding")
//        }else{
//            self.score += self.multiplier + self.autoclicks
//        }
        self.score += self.autoclicks
        
        self.scoreLabel.text = String(format: "Score: %d", arguments: [self.score])
        
        self.saveScore()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        locationManager.stopMonitoringForRegion(beaconRegion)
        self.timer.invalidate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if( CLLocationManager.authorizationStatus() == .AuthorizedAlways ){
            locationManager.startUpdatingLocation()
        }
        
    }
    @IBAction func onImageButton(sender: UIButton) {
        
        baconInBaconAnimation()
        
        if( self.beaconsFound.count != 0 ){
            self.score += self.multiplier
            println("adding")
        }else{
            println("hue")
        }
        self.score = self.score + multiplier
        self.scoreLabel.text = String(format: "Score: %d", arguments: [self.score])
        
        self.saveScore()
    }
    @IBAction func onStoreButton(sender: UIButton) {
        
        self.performSegueWithIdentifier("goToStore", sender: sender)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationManager.stopUpdatingLocation()
        self.currentLocation = locations[0] as? CLLocation
        
        if let location = self.currentLocation {
            if( self.beaconsFound.count != 0 ){
                // SAVE LOCATION TO PARSE
                var locationParse = PFGeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                var object = PFObject(className: "Beacon")
                object["Location"] = locationParse
                object.saveInBackgroundWithBlock({ (sucess: Bool, error: NSError?) -> Void in
                    if let err = error{
                        println("Error")
                    }else{
                        println("Sucessfully saved beacon in Parse")
                    }
                })
                
            }
        }
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
        locationManager.startUpdatingLocation()
        
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
    
    func saveScore() {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let object: NSNumber = userDefaults.objectForKey("score") as? NSNumber {
            userDefaults.setObject(NSNumber(integer: self.score), forKey: "score")
            userDefaults.synchronize()
        }
    }
    
    func getScore() {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let object: NSNumber = userDefaults.objectForKey("score") as? NSNumber {
            self.score = object.integerValue
            self.scoreLabel.text = String(format: "Score: %ld", arguments: [self.score])
        }
    }
    
    func getMultiplierValue() ->Int {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        println("getting multiplier")
        if let value = userDefaults.objectForKey("multiplier") as? NSNumber {
            return value.integerValue
        }else{
            return 1
        }
    }
    func baconInBaconAnimation(){
        
        println("Bacon!")
        
        let bacon = UIImageView()
        var baconX: CGFloat = self.view.frame.size.width/2
        var baconY: CGFloat = self.view.frame.size.height/2
        
        bacon.frame = CGRect(x: baconX, y: baconY, width: 30, height: 50)
        bacon.image = UIImage(named: "bacon-Animation")
        self.view.addSubview(bacon)

 
        var randomToViewWidth : UInt32 = UInt32(self.view.frame.size.width)
        var randomToViewHeight : UInt32 = UInt32(self.view.frame.size.height)
        let randomXOffset = CGFloat(arc4random_uniform(randomToViewWidth))
        let randomYOffset = CGFloat(arc4random_uniform(randomToViewHeight))
        
        let pathR = UIBezierPath()
        pathR.moveToPoint(CGPoint(x: baconX, y: baconY))
        pathR.addLineToPoint(CGPoint(x: randomXOffset, y: randomYOffset))

        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = pathR.CGPath
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = 3
        anim.duration = 1.0
        
        // add the animation
        bacon.layer.addAnimation(anim, forKey: "animate position along path")
        view.bringSubviewToFront(baconButtom)
        
    }
    func getAutoClicks() ->Int {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        println("getting autoclicker")
        if let value = userDefaults.objectForKey("autoclicker") as? NSNumber {
            return value.integerValue
        }else{
            return 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.destinationViewController is UINavigationController && ( segue.destinationViewController as! UINavigationController ).viewControllers[0] is StoreViewController ) {
            var nVC = segue.destinationViewController as! UINavigationController
            var dVC = nVC.viewControllers[0] as! StoreViewController
            dVC.money = self.score
        }
    }

}
    
    
    


