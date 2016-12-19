//
//  SecondViewController.swift
//  FridgeApp
//
//  Copyright © 2016 Vinnie Chen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    // Reference to text boxes in storyboard
    @IBOutlet var txtFood: UITextField!
    @IBOutlet var txtDate: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Events
    @IBAction func btnAddFood_Click(sender: UIButton) {
        let date = foodMgr.calculateDate() // get date, convert to string
        
        foodMgr.addFood(name: txtFood.text!, date: date) // Add food and date to array
        self.view.endEditing(true) // hide keyboard
        txtFood.text! = "" // clear text boxes
        txtDate.text! = ""
        self.tabBarController?.selectedIndex = 0
        
    }
    
    // Touch Functions: Hide keyboard when touching out of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // hide keyboard
    }
    
    // UITextFieldDelegate
     func textFieldShouldReturn(_ textField: UITextField) -> Bool{ // ???
        textField.resignFirstResponder() // hides keyboard
        return true
    }
 

}

