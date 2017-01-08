//
//  DBManager.swift
//  FridgeApp
//
//  Created by Vinnie Chen on 12/31/16.
//  Copyright © 2016 Vinnie Chen. All rights reserved.
//

import UIKit
import Foundation

class DBManager: NSObject {
    
    // Makes singleton class
    static let shared: DBManager = DBManager()
    
    // Name
    let databaseName = "fridge.sqlite"
    
    // Path to database file
    var pathtoDataBase: String!
    
    // FMDatabase Object that accesses and operates on database
    var database: FMDatabase!
    
    let field_FoodName = "name"

    
    override init() {
        super.init()
        openDatabase()
    }
    
    // Open database
    func openDatabase() -> Bool {
        // Create path to database
        let fileManager = FileManager.default
      
        //let documents_dir = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        //let db_Path = documents_dir.appending(databaseName)
       // NSString *template_path = [[NSBundle mainBundle] pathForResource:@"template_db" ofType:@"s3db"];
       let db_Path = Bundle.main.path(forResource: "fridge", ofType: "sqlite")! // Bundle path
        
    
        // Copy to documents to edit
        let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        let targetPath = libraryPath.appending("fridge.sqlite")
        
        if (!fileManager.fileExists(atPath: targetPath)) {
            // database doesn't exist in your library path, copy it from bundle
            let sourcePath = Bundle.main.path(forResource: "fridge", ofType: "sqlite")!
            let error : NSError? = nil
            
            do {
                try fileManager.copyItem(atPath: sourcePath, toPath: targetPath)
            }
            catch {
                NSLog("Error \(error)")
            }
            
        }
        
        // create database
        let database = FMDatabase(path: targetPath)

        
        // Open read-only database
        if !(database?.open())! {
            print("Could not open database at \(db_Path).")
            return false
        } else {
            self.database = database;
        }
        return true
    }
    
    // Close database
    func closeDatabase() -> Bool {
        if (database != nil) {
            database.close()
            return true
        }
        return false
    }
    
    // Search table food for shelf life of parameter foodName - SELECT
    func searchAddFood(foodName: String) -> Int {
        var shelfLife: Int!
        
        if openDatabase() {
            let querySearch = "SELECT * FROM food_ShelfLife WHERE foodName=?" // find food based on name
            
            do {
                let foodResultSet = try database.executeQuery(querySearch, values: [foodName.lowercased()])
                
                if foodResultSet.next() {
                    shelfLife = Int(foodResultSet.int(forColumn: "shelfLife"))
                    do {
                        // add food to table food_InFridge
                        let queryAddToFridge = "INSERT INTO food_InFridge (foodName, shelfLife) VALUES (\(foodName), \(shelfLife))"
                        try database.executeUpdate(queryAddToFridge, values: nil)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
                else { // food not found
                    print("food not found")
                    // popup to create custom food? auto suggest?
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        return shelfLife
    }
    
    
    
}
