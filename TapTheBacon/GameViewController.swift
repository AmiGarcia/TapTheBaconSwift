//
//  GameViewController.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 06/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func onImageButton(sender: UIButton) {
        
        scoreLabel.text = String(format: "Score: %d", arguments: [++score])
    }
    @IBAction func onStoreButton(sender: UIButton) {
        
        self.performSegueWithIdentifier("goToStore", sender: sender)
    }

}
