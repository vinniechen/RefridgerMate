//
//  CustomFoodViewController.swift
//  FridgeApp
//
//  Created by Vinnie Chen on 12/16/16.
//  Copyright © 2016 Vinnie Chen. All rights reserved.
//


import UIKit

class CustomFoodViewController: UIViewController {
    
    @IBOutlet var picker: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Input data into the Array:
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    }
}
