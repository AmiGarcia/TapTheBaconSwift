//
//  Product.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 08/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit

class Product: NSObject {
    var name: String
    var price: Double
    
    init(name:String, price: Double){
        self.name = name
        self.price = price
        super.init()
    }
   
}
