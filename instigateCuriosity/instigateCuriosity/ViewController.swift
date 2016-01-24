//
//  ViewController.swift
//  instigateCuriosity
//
//  Created by Wyatt Endres on 1/23/16.
//  Copyright © 2016 Wyatt Endres. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var headLineTextView: UITextView!
    @IBOutlet weak var updateButtonField: UIButton!
    @IBOutlet weak var headLineTitleLabel: UILabel!
    @IBOutlet weak var logOutButtonField: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field’s user input through delegate callbacks.
        headLineTextView.delegate = self
        
        //Give headlineTextField focus
        headLineTextView.becomeFirstResponder()
        
        //Grab Current Headline from Parse DB and set headlineLabel equal to it
        let query = PFQuery(className:"Headline")
        query.getObjectInBackgroundWithId("QZVUNUutyi") {
            (headline: PFObject?, error: NSError?) -> Void in
            if error == nil && headline != nil {
                let currentHeadline = headline!["Text"] as! String
                self.headLineTextView.text = currentHeadline
            } else {
                print(error)
            }
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        updateButtonField.backgroundColor = UIColor.whiteColor()
    }
    
    func textViewDidChange(textView: UITextView) {
        updateButtonField.backgroundColor = UIColor.blackColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateHeadLine(sender: AnyObject) {
        // Hide the keyboard.
        headLineTextView.resignFirstResponder()
        //Query parse for headline and update
        if self.headLineTextView.text != "" {
            let query = PFQuery(className:"Headline")
            query.getObjectInBackgroundWithId("QZVUNUutyi") {
                (headline: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let headline = headline {
                    headline["Text"] = self.headLineTextView.text
                    headline.saveInBackground()
                }
            }
        } else {
            self.headLineTextView.text = "@Username is an idiot"
        }
     
       
    }
    
    @IBAction func levelUpButton(sender: AnyObject) {
        
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        PFUser.logOutInBackground()
        _ = PFUser.currentUser()
    }
    
    
    


}

