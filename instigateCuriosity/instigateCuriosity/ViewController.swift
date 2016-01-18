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
        
        //Grab Current Headline from Parse DB and set headlineLabel equal to it
        
        
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
        headlineTextField.text = ""

    }
    
    
    //MARK: Actions
    @IBAction func setHeadlineAction(sender: AnyObject) {
        headlineLabel.text = "Default Headline"
    }
    


}

