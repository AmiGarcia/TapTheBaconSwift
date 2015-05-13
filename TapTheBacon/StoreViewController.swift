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
    
//    // Contains All Products
//    var products: NSArray = /* TESTING */ [
//        
//        // CLICK MULTIPLIERS
//        Product(name: "Click Multiplier", price: 5, multiplier: 2, autoClicks: 0, imageName:"bacon"),
//        Product(name: "Super Click Multiplier", price: 10, multiplier: 4, autoClicks: 0, imageName:"bacon"),
//        Product(name: "Mega Click Multiplier", price: 20, multiplier: 8, autoClicks: 0, imageName:"bacon"),
//        Product(name: "Hiper Click Multiplier", price: 50, multiplier: 16, autoClicks: 0, imageName:"bacon"),
//        Product(name: "Ultra Click Multiplier", price: 200, multiplier: 32, autoClicks: 0, imageName:"bacon"),
//        
//        // AUTOCLICKERS
//        Product(name: "AutoClicker", price: 100, multiplier: 1, autoClicks: 1, imageName:"bacon"),
//        Product(name: "Grandpa", price: 200, multiplier: 1, autoClicks: 5, imageName:"bacon"),
//        Product(name: "Baconizer", price: 1000, multiplier: 1, autoClicks: 20, imageName:"bacon"),
//        Product(name: "Bacon Canon", price: 2000, multiplier: 1, autoClicks: 100, imageName:"bacon"),
//        Product(name: "Bacon Provider", price: 10000, multiplier: 1, autoClicks: 200, imageName:"bacon")
//    ]
    var products: DataBase = DataBase(array: [
        
            // CLICK MULTIPLIERS
            Product(name: "Click Multiplier", price: 5, multiplier: 2, autoClicks: 0, imageName:"first"),
            Product(name: "Super Click Multiplier", price: 10, multiplier: 4, autoClicks: 0, imageName:"second"),
            Product(name: "Mega Click Multiplier", price: 20, multiplier: 8, autoClicks: 0, imageName:"third"),
            Product(name: "Hiper Click Multiplier", price: 50, multiplier: 16, autoClicks: 0, imageName:"fourth"),
            Product(name: "Ultra Click Multiplier", price: 200, multiplier: 32, autoClicks: 0, imageName:"fifth"),
    
            // AUTOCLICKERS
            Product(name: "AutoClicker", price: 100, multiplier: 1, autoClicks: 1, imageName:"bacon"),
            Product(name: "Grandpa", price: 200, multiplier: 1, autoClicks: 5, imageName:"bacon"),
            Product(name: "Baconizer", price: 1000, multiplier: 1, autoClicks: 20, imageName:"bacon"),
            Product(name: "Bacon Canon", price: 2000, multiplier: 1, autoClicks: 100, imageName:"bacon"),
            Product(name: "Bacon Provider", price: 10000, multiplier: 1, autoClicks: 200, imageName:"bacon")
        ]

    )
    var selectedProducts: NSMutableArray = NSMutableArray()
    var money: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if( !self.products.hasObjectsInUserDefaults() ) {
            self.products = DataBase(array: [
                
                // CLICK MULTIPLIERS
                Product(name: "Click Multiplier", price: 5, multiplier: 2, autoClicks: 0, imageName:"first"),
                Product(name: "Super Click Multiplier", price: 10, multiplier: 4, autoClicks: 0, imageName:"second"),
                Product(name: "Mega Click Multiplier", price: 20, multiplier: 8, autoClicks: 0, imageName:"third"),
                Product(name: "Hiper Click Multiplier", price: 50, multiplier: 16, autoClicks: 0, imageName:"fourth"),
                Product(name: "Ultra Click Multiplier", price: 200, multiplier: 32, autoClicks: 0, imageName:"fifth"),
                
                // AUTOCLICKERS
                Product(name: "AutoClicker", price: 100, multiplier: 1, autoClicks: 1, imageName:"bacon"),
                Product(name: "Grandpa", price: 200, multiplier: 1, autoClicks: 5, imageName:"bacon"),
                Product(name: "Baconizer", price: 1000, multiplier: 1, autoClicks: 20, imageName:"bacon"),
                Product(name: "Bacon Canon", price: 2000, multiplier: 1, autoClicks: 100, imageName:"bacon"),
                Product(name: "Nuclearackon", price: 10000, multiplier: 1, autoClicks: 200, imageName:"bacon")
            ])
            self.products.saveInUserDefaults()
        }
        self.products.updateDataFromUserDefaults()
        self.tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = String(money)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.saveScore()
//        self.products.saveInUserDefaults()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var productAtIndex = products[ indexPath.row ] as Product
        var productName = cell.viewWithTag(1) as! UILabel
        var productPrice = cell.viewWithTag(2) as! UILabel
        var productImage = cell.viewWithTag(3) as! UIImageView
        productName.text = productAtIndex.name
        productPrice.text = String(format: "$%.2lf", arguments: [productAtIndex.price])
        productImage.image = UIImage(named: productAtIndex.imageName )
        //productImage.image = UIImage(named: "haha")
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor = UIColor.clearColor()
        cell.backgroundView?.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame:CGRectZero)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = cell.bounds
        cell.insertSubview(blurEffectView, atIndex: 0)
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
        
        if( self.money < self.priceForSelectedItems() ){
            var alert = UIAlertView(title: "Not Enough Bacons", message: "You should get more bacons", delegate: nil, cancelButtonTitle: "Got it!")
            alert.show()
            
        }else{
            self.money -= self.priceForSelectedItems()
            
            self.updatePriceForSelectedItems()
            self.saveData()
            self.tableView.reloadData()
            self.selectedProducts.removeAllObjects()
        }
        self.title = String(money)
    }
    
    func updatePriceForSelectedItems() {
        for product: Product in NSArray(array: self.selectedProducts) as! [Product] {
            var index = find(self.products.products, product)
            if let i = index {
                println("here")
                var actualProduct = self.products[i]
                actualProduct.price *= 2
            }
        }
        products.saveInUserDefaults()
        products.updateDataFromUserDefaults()
    }
    
    
    func priceForSelectedItems()->Int {
        var totalPrice = 0
        for product: Product in NSArray(array: self.selectedProducts) as! [Product] {
            totalPrice += Int(product.price)
        }
        return totalPrice
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
        for product: Product in NSArray(array: self.selectedProducts) as! [Product] {
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
        for product: Product in NSArray(array: self.selectedProducts) as! [Product] {
            // increments autoclicker
            currentAutoClicks += product.autoClicks
        }
        userDefaults.setObject(NSNumber(integer: currentAutoClicks), forKey: autoclickerKey)
        
        // syncronize
        userDefaults.synchronize()
        
    }
    func saveScore() {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        if let object: NSNumber = userDefaults.objectForKey("score") as? NSNumber {
            userDefaults.setObject(NSNumber(integer: self.money), forKey: "score")
            userDefaults.synchronize()
        }
    }
}
