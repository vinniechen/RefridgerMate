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
let foodSort = NSSortDescriptor(key: "date", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:))) // sort by date

struct foodItem {
    var name = "No_Name"
    var expDate: Date?

    
}

class FoodManager: NSObject {
    
    var foods = NSMutableOrderedSet();
    
    // Add food
    func addFood(name: String, date: String) {
        
        let expDate = setExpirationDate(food: name) // get the expiration date
        foods.add(foodItem(name: name, expDate: expDate))
        //foods.sort(using: [foodSort]) // sort by date
    }
    
    // Assign expDate in foodItem
    func setExpirationDate(food: String) -> Date {
        // Get shelf life of food
        var shelfLife: Int! // currently constant val, will change to pull from database
        
        shelfLife = DBManager.shared.searchAddFood(foodName: food)
        
        
        
        let addDate = Date()
        let cal = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let expirationDate = cal?.date(byAdding: NSCalendar.Unit.day, value: shelfLife, to: addDate, options: [])
        return expirationDate!
    }
    
    // Calculate Int days until Expiration for food
    func getDaysToExp(expDate: Date) -> Int {
        let cal = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let currDate = Date()
        
        let date1 = cal?.startOfDay(for: expDate)
        let date2 = cal?.startOfDay(for: currDate)
        
        let flags = NSCalendar.Unit.day
        let dayDifference = cal?.components(flags, from: date1!, to: date2!, options: [])
      return abs(dayDifference!.day!)
    }
    
    // Format string to be used in TableView
    func formatForView(totalDays: Int) -> String {
        if (totalDays == 0) { return "Expires Today" }
        
        // calculate the weeks and the days
        let days = totalDays % 7
        let weeks = totalDays/7
        
        var formattedString = ""
        
        // prints __ week(s) __ day(s)
        if (weeks > 0) {
            if (days == 1) {
                formattedString += "\(weeks) week "
            }
            else {
                formattedString += "\(weeks) weeks "
            }
        }
        if (days > 0) {
            
            if (days == 1) {
                formattedString += "\(days) day "
            }
            else {
                formattedString += "\(days) days "
            }
        }
        
        return formattedString
    }
    
    // Returns string of current date in dd-MM-yyyy
    func calculateDate() -> String {
        let NSdate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: NSdate)
        return date
    }
}
