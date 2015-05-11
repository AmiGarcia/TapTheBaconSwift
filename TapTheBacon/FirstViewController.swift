//
//  ViewController.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 06/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getScore()
    }
    
    func getScore(){
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let object: NSNumber = userDefaults.objectForKey("score") as? NSNumber {
            self.score = object.integerValue
        }else{
            userDefaults.setObject(NSNumber(integer: 0), forKey: "score")
            userDefaults.synchronize()
        }
    }
    
    @IBAction func onStartButton(sender: UIButton) {
        
        self.performSegueWithIdentifier("goToGame", sender: sender)
    }

    @IBAction func onHighScoreButton(sender: UIButton) {
        
        self.performSegueWithIdentifier("goToHighScore", sender: sender)
    }
    @IBAction func onMapButton(sender: UIButton) {
        
        self.performSegueWithIdentifier("goToMap", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( segue.destinationViewController is GameViewController ){
            var dVC = segue.destinationViewController as! GameViewController
            dVC.score = self.score
        }
    }
}

