//
//  Product.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 08/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit

class Product: NSObject, Printable {
    var name: String
    var price: Double
    
    var multiplier: Int
    var autoClicks: Int
    
    var imageName: String
    
    
    override var description: String { return "name: " + self.name + " price: " + String(stringInterpolationSegment: price)}
    
    init(name:String, price: Double, multiplier: Int, autoClicks: Int, imageName: String) {
        
        self.name = name
        self.price = price
        self.multiplier = multiplier
        self.autoClicks = autoClicks
        self.imageName = imageName
        
        super.init()
    }
   
}
