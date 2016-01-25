//
//  Information.swift
//  instigateCuriosity
//
//  Created by Wyatt Endres on 1/24/16.
//  Copyright © 2016 Wyatt Endres. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class Information: UIViewController, UITextViewDelegate {
    
    let logOutSuccessMessage = "Logging Out!"
    let logOutNoUserMessage = "You must be signed in to log out!"
    
    @IBOutlet weak var informationTextView: UITextView!
    
    
    override func viewWillAppear(animated: Bool) {
        //give text view a delegate
        informationTextView.delegate = self
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        informationTextView.text = logOutSuccessMessage
        logOutCurrentParseUser()
        dispatchToMainScreen()
    }
    
    //logout current user and send them to main
    func logOutCurrentParseUser(){
        if isUserLoggedIn() == true {
            PFUser.logOutInBackground()
            _ = PFUser.currentUser()
        } else {
            self.informationTextView.text = logOutNoUserMessage
        }
    }
    
    func isUserLoggedIn () ->Bool {
        if (PFUser.currentUser() == nil) {
            return false
        } else {
            return true
            
        }
    }
    
    func dispatchToMainScreen(){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
}
