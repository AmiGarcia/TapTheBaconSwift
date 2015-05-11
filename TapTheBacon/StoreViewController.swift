//
//  StoreViewController.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 06/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit
import StoreKit
import CoreData

class StoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // Contains All Products
    var products: NSArray = /* TESTING */ [
        
        // CLICK MULTIPLIERS
        Product(name: "Click Multiplier", price: 5, multiplier: 2, autoClicks: 0),
        Product(name: "Super Click Multiplier", price: 10, multiplier: 4, autoClicks: 0),
        Product(name: "Mega Click Multiplier", price: 20, multiplier: 8, autoClicks: 0),
        Product(name: "Hiper Click Multiplier", price: 50, multiplier: 16, autoClicks: 0),
        Product(name: "Ultra Click Multiplier", price: 200, multiplier: 32, autoClicks: 0),
        
        // AUTOCLICKERS
        Product(name: "AutoClicker", price: 100, multiplier: 1, autoClicks: 1),
        Product(name: "Grandpa", price: 200, multiplier: 1, autoClicks: 5),
        Product(name: "Baconizer", price: 1000, multiplier: 1, autoClicks: 20)
    ]
    var selectedProducts: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var productAtIndex = products[ indexPath.row ] as! Product
        var productName = cell.viewWithTag(1) as! UILabel
        var productPrice = cell.viewWithTag(2) as! UILabel
        productName.text = productAtIndex.name
        productPrice.text = String(format: "$%.2lf", arguments: [productAtIndex.price])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedProducts.removeObject( products[indexPath.row]  )
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedProducts.addObject( products[indexPath.row] )
    }
    
    @IBAction func onBuyButton(sender: UIBarButtonItem) {
        println("setting current multiplier")
        self.saveData()
        
        self.tableView.reloadData()
        self.selectedProducts.removeAllObjects()
    }
    
    func saveData() {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        // Save current mutliplier
        let multiplierKey = "multiplier"
        
        if ( userDefaults.objectForKey(multiplierKey) == nil ){
            userDefaults.setObject(NSNumber(integer: 1), forKey:multiplierKey)
            userDefaults.synchronize()
        }
        
        // Multiplier will be stored with the key "multiplier" and the value of the multiplier
        let object: NSNumber = userDefaults.objectForKey(multiplierKey) as! NSNumber
        
        // determines maximum multiplier in product array
        var maxMultiplier = object.integerValue
        for product: Product in self.products as! [Product] {
            if( product.multiplier > maxMultiplier ){
                maxMultiplier = product.multiplier
            }
        }
        userDefaults.setObject( NSNumber(integer: maxMultiplier) , forKey:multiplierKey)
        
        // Save current autoclicker
        let autoclickerKey = "autoclicker"
        if( userDefaults.objectForKey(autoclickerKey) == nil ){
            userDefaults.setObject(NSNumber(integer: 0), forKey: autoclickerKey)
        }
        
        var currentAutoClicks = (userDefaults.objectForKey(autoclickerKey) as! NSNumber).integerValue
        for product: Product in self.products as! [Product] {
            // increments autoclicker
            currentAutoClicks += product.autoClicks
        }
        userDefaults.setObject(NSNumber(integer: currentAutoClicks), forKey: autoclickerKey)
        
        // syncronize
        userDefaults.synchronize()
    }
    
}
