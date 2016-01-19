//
//  ViewController.swift
//  instigateCuriosity
//
//  Created by Wyatt Endres on 1/17/16.
//  Copyright © 2016 Wyatt Endres. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var headlineTextField: UITextField!
    @IBOutlet weak var headlineLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Handle the text field’s user input through delegate callbacks.
        headlineTextField.delegate = self
        
        //Give headlineTextField focus
        headlineTextField.becomeFirstResponder()
        
        //Grab Current Headline from Parse DB and set headlineLabel equal to it
        let query = PFQuery(className:"Headline")
        query.getObjectInBackgroundWithId("QZVUNUutyi") {
            (headline: PFObject?, error: NSError?) -> Void in
            if error == nil && headline != nil {
                let currentHeadline = headline!["Text"] as! String
                self.headlineLabel.text = currentHeadline
            } else {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        headlineLabel.text = textField.text
        let query = PFQuery(className:"Headline")
        query.getObjectInBackgroundWithId("QZVUNUutyi") {
            (headline: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let headline = headline {
                headline["Text"] = self.headlineLabel.text
                headline.saveInBackground()
            }
        }
        
        headlineTextField.text = ""

    }
    
    //MARK: Actions
    @IBAction func refreshHeadline(sender: AnyObject) {
        headlineLabel.text = "refreshed!"
    }
    
    @IBAction func keepHeadline(sender: AnyObject) {
        headlineLabel.text = "level up!"
    }
    
    
    
    


}

