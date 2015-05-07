//
//  ViewController.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 06/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
}

