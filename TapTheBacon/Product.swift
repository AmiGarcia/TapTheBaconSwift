//
//  Product.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 08/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit

class Product: NSObject, NSCoding {
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
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(NSNumber(double: self.price), forKey: "price")
        aCoder.encodeObject(NSNumber(integer: self.multiplier), forKey: "multiplier")
        aCoder.encodeObject(NSNumber(integer: self.autoClicks), forKey: "autoclicks")
        aCoder.encodeObject(self.imageName, forKey: "imageName")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.price = (aDecoder.decodeObjectForKey("price") as! NSNumber).doubleValue
        self.multiplier = (aDecoder.decodeObjectForKey("multiplier") as! NSNumber).integerValue
        self.autoClicks = (aDecoder.decodeObjectForKey("autoclicks") as! NSNumber).integerValue
        self.imageName = aDecoder.decodeObjectForKey("imageName") as! String
        
        super.init()
    }
   
}
