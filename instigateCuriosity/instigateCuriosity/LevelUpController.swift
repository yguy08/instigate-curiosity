//
//  LevelUpController.swift
//  instigateCuriosity
//
//  Created by Wyatt Endres on 1/23/16.
//  Copyright © 2016 Wyatt Endres. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class LevelUpController: UIViewController {
    
    
    //Check if existing user
    override func viewWillAppear(animated: Bool) {
        //call level up method to check user money and decide what level up to display
        levelUpMethod()

    }
    
    //method for checking user money and taking to screen based on level
    func levelUpMethod(){
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        } else {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
        
    }
    
    
    
}
