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
    
    @IBOutlet weak var informationTextView: UITextView!
    
    
    override func viewWillAppear(animated: Bool) {
        //give text view a delegate
        informationTextView.delegate = self

        
    }
    
    
    @IBAction func logOutAction(sender: AnyObject) {
        informationTextView.text = "Logging Out!"
        logOutCurrentParseUser()
    }
    
    
    
    //logout current user and send them to main
    func logOutCurrentParseUser(){
        if isUserLoggedIn() == true {
            PFUser.logOutInBackground()
            _ = PFUser.currentUser()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        } else {
            self.informationTextView.text = "You must be signed in to sign out!"
        }
        
        
    }
    
    
    func isUserLoggedIn () ->Bool {
        if (PFUser.currentUser() == nil) {
            return false
        } else {
            return true
            
        }
    }
}
