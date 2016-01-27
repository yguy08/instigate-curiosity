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
    
    let HeadLineClassName = "Headline"
    let HeadLineObjectIdString = "QZVUNUutyi"
    let noUserSignedInMessageText = "Good Luck!"
    let noMoneyMessageText = "💩"
    let userSignedInBlankTextEnteredMessage = ", you're an idiot...you can't submit a blank headline..try again."
    let noUserSignedInBlankTextEnteredMessage = "You can't submit a blank headline...try again."

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
        
        //get current user and set to header name
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
        getMoneyBalance()
    }
    
    //Custom Functions
    func DisplayCurrentHeadlineInTextView(){
        //Grab Current Headline from Parse DB
        let query = PFQuery(className:(HeadLineClassName))
        query.getObjectInBackgroundWithId((HeadLineObjectIdString)) {
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
            let query = PFQuery(className: (HeadLineClassName))
            query.getObjectInBackgroundWithId((HeadLineObjectIdString)) {
                (headline: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let headline = headline {
                    headline["Text"] = self.headLineTextView.text
                    headline.saveInBackground()
                }
            }
        } else {
            emptyHeadlineTextField()
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
        } else {
            headlineLabel.text = noMoneyMessageText
        }
    }
    
    //updated func to set header to balance with new money class. Needs testing.
    func getMoneyBalance(){
        let currentUser = PFUser.currentUser()
        let currentUserName = currentUser?.username
        if  currentUser != nil {
            let query = PFQuery(className: "Money")
            query.whereKey("accountName", equalTo: currentUserName!)
            query.getFirstObjectInBackgroundWithBlock {
                (object: PFObject?, error: NSError?) -> Void in
                if error != nil || object == nil {
                    print("The getFirstObject request failed.")
                } else {
                    // The find succeeded.
                    print("Successfully retrieved the object.")
                    let money = object!["money"] as! Int
                    print(String(money))
                    self.headlineLabel.text = String (money)
                }
            }
        } else {
            headlineLabel.text = noMoneyMessageText
        }
    }
    
    //get the current user username and set to header
    func getCurrentUserName() {
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            headlineLabel.text = currentUser?.username
        } else {
            headlineLabel.text = noUserSignedInMessageText
        }
    }
    
    //empty text view function telling user they are dumb if no text entered. first check if user is logged in
    func emptyHeadlineTextField(){
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            headLineTextView.text = (currentUser?.username)! + userSignedInBlankTextEnteredMessage
                headLineTextView.becomeFirstResponder()
            //get text view character count and hightlight to make easier to delete
            getTextViewCountAndMakeSelectedRange()
        } else {
            headLineTextView.text = noUserSignedInBlankTextEnteredMessage
            headLineTextView.becomeFirstResponder()
            getTextViewCountAndMakeSelectedRange()
        }
    }
    
    //get textViewCharacter count and highlight textView field
    func getTextViewCountAndMakeSelectedRange (){
        let headLineTextViewStringCount = headLineTextView.text.characters.count
        headLineTextView.selectedRange = NSMakeRange(0, (headLineTextViewStringCount))
    }
    
}

