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
    var name = "Unnamed"
    var desc = "Undescribed"
    
}

class FoodManager: NSObject {

    var foods = [foodItem]();
    func addFood(name: String, desc: String) {
        foods.append(foodItem(name: name, desc: desc))
    }
}
