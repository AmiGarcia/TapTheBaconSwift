//
//  StoreViewController.swift
//  TapTheBacon
//
//  Created by Nicolas Nascimento on 06/05/15.
//  Copyright (c) 2015 Nascimento. All rights reserved.
//

import UIKit
import StoreKit

class StoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // Contains All Products
    var products: NSMutableArray = /* TESTING */ [Product(name: "Cookie", price: 0.99), Product(name: "Bacon", price: 1.99)]
    
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
        selectedProducts.removeObject( products[indexPath.row] )
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedProducts.addObject( products[indexPath.row] )
    }
    

}
