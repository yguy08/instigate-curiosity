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
    @IBOutlet weak var headlineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text view’s user input through delegate callbacks.
        headLineTextView.delegate = self
        
        //Give headlineTextField focus
        headLineTextView.becomeFirstResponder()
        
        //grab headline from parse and display in text view
        DisplayCurrentHeadlineInTextView()
        
        //get current user
        getCurrentUserName()
        
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        updateButtonField.backgroundColor = UIColor.whiteColor()
    }
    
    func textViewDidChange(textView: UITextView) {
        updateButtonField.backgroundColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func updateHeadLine(sender: AnyObject) {
        updateHeadLine()
     }
    
    @IBAction func checkBalanceAction(sender: AnyObject) {
        getCurrentBalance()
    }
    
    //Custom Functions
    func DisplayCurrentHeadlineInTextView(){
        //Grab Current Headline from Parse DB
        let query = PFQuery(className:"Headline")
        query.getObjectInBackgroundWithId("QZVUNUutyi") {
            (headline: PFObject?, error: NSError?) -> Void in
            //if no error and text in text view then set headline to textview.txt
            if error == nil && headline != nil {
                let currentHeadline = headline!["Text"] as! String
                self.headLineTextView.text = currentHeadline
            } else {
                print(error)
            }
        }
    }
    
    func updateHeadLine(){
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
    
    func getCurrentBalance(){
        let currentUser = PFUser.currentUser()
        let currentUserName = currentUser?.username
        if currentUser != nil{
            let query = PFUser.query()
            query!.whereKey("username", equalTo: currentUserName!)
            let money = currentUser!["money"] as! Int
            headlineLabel.text = String (money)
        }
    }
    
    //get the current user username and set to header
    func getCurrentUserName() {
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            headlineLabel.text = currentUser?.username
        } else {
            headlineLabel.text = "Good luck!"
        }
    }
    
    
    
}

