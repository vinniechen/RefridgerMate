//
//  CustomViewController.swift
//  FridgeApp
//
//  Created by Vinnie Chen on 12/18/16.
//  Copyright © 2016 Vinnie Chen. All rights reserved.
//

import UIKit

struct FoodShelfLifeItem {
    var foodName: String!
    var foodShelfLife: Int!
}


class CustomViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var customName: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [[String]] = [[String]]()
    
    
    
    // To be put into database
    var customFoodName: String = ""
    var weekShelfLife: Int = 0
    var dayShelfLife: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Connect data delegate, data source:
        self.picker.delegate = self
        self.picker.dataSource = self

        
        // Input data into the Array:
        /* var months: [String] = ["Months"]
        // Months: 1 - 12
        for i in 1...12 {
            let month: String = "\(i)"
            months.append(month)
        } */
        
        // Weeks: 1 - 52
        var weeks: [String] = ["Weeks"]
        for i in 1...52 { // Fill Array
            let week: String = "\(i)"
            weeks.append(week)
        }
        
        // Days
        var days: [String] = ["Days"]
        for j in 1...7 { // Fill Array
            let day: String = "\(j)"
            days.append(day)
        }
        
        // Picker data
        pickerData = [weeks, days]
        
        self.picker.delegate = self
        self.picker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(pickerData[component][row])
        return pickerData[component][row]
    }
    
    // Function is triggered when the user makes a change to the picker selection.
    //The parameter named row and component represents what was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // week
        if (component == 0) {
            weekShelfLife = row
        }
            // day
        else {
            dayShelfLife = row
        }
        
    }
    
    @IBAction func btnAddCustomFood_Click(_ sender: Any) {
        // Assign String and Int to be added to database
        customFoodName = customName.text!
        if (customFoodName.isEmpty) { // checks that there is food name entered
            print("Enter a name for your food")
        }
        let totalShelfLife = (weekShelfLife * 7) + dayShelfLife
        if (totalShelfLife) == 0 {
            print("Add shelf life of at least 1 day")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
