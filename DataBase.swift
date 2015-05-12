//
//  DataBase.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 12/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit

class DataBase: NSObject {
    var products: [Product] = [Product]()
    var count: Int {
        return products.count
    }
    
    init(array: [Product]) {
        self.products = array
        super.init()
        
    }
    
    func saveInUserDefaults() {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        println("saving in user defaults")
        
        for p: Product in products{
            var encodedProduct = NSKeyedArchiver.archivedDataWithRootObject(p)
            if let object: AnyObject = userDefaults.objectForKey(p.name) {
                userDefaults.setObject(encodedProduct, forKey:p.name)
            }else{
                userDefaults.setObject(encodedProduct, forKey: p.name)
            }
        }
        userDefaults.synchronize()
    }
    func updateDataFromUserDefaults() {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        for p: Product in products{
            var decodedProduct: Product = NSKeyedUnarchiver.unarchiveObjectWithData(userDefaults.objectForKey(p.name) as! NSData) as! Product
            
            p.name = decodedProduct.name
            p.price = decodedProduct.price
            p.multiplier = decodedProduct.multiplier
            p.autoClicks = decodedProduct.autoClicks
            p.imageName = decodedProduct.imageName
        }
    }
    
    func hasObjectsInUserDefaults() ->Bool {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        for p: Product in products{
            if( userDefaults.objectForKey(p.name) == nil ){
                return false
            }
        }
        return true
    }
    
    subscript(index: Int)-> Product{
        get{
            return self.products[index]
        }
        set(newValue){
            self.products[index] = newValue
        }
    }
}
