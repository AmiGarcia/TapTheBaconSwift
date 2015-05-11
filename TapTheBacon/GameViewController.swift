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
let identifier = "505d009c8b46d6fb"


class GameViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var baconButtom: UIButton!
    
    var score: Int = 0
    
    var beaconsFound: [CLBeacon] = [CLBeacon]()
    let locationManager = CLLocationManager()
    var beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    @IBAction func onImageButton(sender: UIButton) {
        
        baconInBaconAnimation()
        
        if( self.beaconsFound.count != 0 ){
            self.score++
        }
        
        self.scoreLabel.text = String(format: "Score: %d", arguments: [++self.score])
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
        self.beaconsFound = [CLBeacon]()
        locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        println("hey")
        
        if (beacons.count > 0) {
            beaconsFound = beacons as! [CLBeacon]
            
            // update stuff based on beacons list
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

        println(randomToViewWidth)
        println(randomToViewHeight)
        println(randomXOffset)
        println(randomYOffset)
        
        
        let pathR = UIBezierPath()
        pathR.moveToPoint(CGPoint(x: baconX, y: baconY))
        pathR.addLineToPoint(CGPoint(x: randomXOffset, y: randomYOffset))
//        pathR.addCurveToPoint(CGPoint(x: 301, y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))

        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = pathR.CGPath
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = 1
        anim.duration = 3.0
        
        // add the animation
        bacon.layer.addAnimation(anim, forKey: "animate position along path")
        view.bringSubviewToFront(baconButtom)
        
    }

    
    }
    
    
    


