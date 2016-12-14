//
//  FoodManager.swift
//  FridgeApp
//
//  Created by Vinnie Chen on 11/22/16.
//  Copyright © 2016 Vinnie Chen. All rights reserved.
//

import UIKit

// Global Scope
var foodMgr: FoodManager = FoodManager() // creates instance of FoodManager

struct foodItem {
    var name = "No_Name"
    var date = "No_Date"
    
}

class FoodManager: NSObject {

    var foods = [foodItem]();
    func addFood(name: String, date: String) {
        foods.append(foodItem(name: name, date: date))
    }
}
