//
//  FirstViewController.swift
//  FridgeApp
//
//  Created by Vinnie Chen on 11/22/16.
//  Copyright © 2016 Vinnie Chen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblFood: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Update the list
    override func viewWillAppear(_ animated: Bool) {
        tblFood.reloadData()
    }
    
    // UITableViewDelete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            foodMgr.foods.removeObject(at: indexPath.row)
            tblFood.reloadData()
        }
    }
    
    // UITableViewDataSource
    
    
    // Number of rows needed to be rendered
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodMgr.foods.count
    }
    
    // Create cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default")
 
        // grab food from foodMgr
        let food = (foodMgr.foods.object(at: indexPath.row) as! foodItem).name
        cell.textLabel?.text = food
       
        // grab expiration date
        let nsExpDate: Date = (foodMgr.foods.object(at: indexPath.row) as! foodItem).expDate!
        
        // assign days until expiration cell.text
        let daysToExpiration: Int = foodMgr.getDaysToExp(expDate: nsExpDate)
        
        
        cell.detailTextLabel?.text = foodMgr.formatForView(totalDays: daysToExpiration)
 
        return cell;
    }
}

