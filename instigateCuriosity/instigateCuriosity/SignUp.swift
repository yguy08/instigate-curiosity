//
//  SignUp.swift
//  instigateCuriosity
//
//  Created by Wyatt Endres on 1/24/16.
//  Copyright © 2016 Wyatt Endres. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts



class SignUp: UIViewController, UITextFieldDelegate {
    
    //sign up bonus for signing up
    let SignUpBonus = 1000000000000
    
    
    @IBOutlet weak var signUpUserNameTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    
    
    override func viewWillAppear(animated: Bool) {
        
        // Handle the text field’s user input through delegate callbacks.
        signUpUserNameTextField.delegate = self
        signUpPasswordTextField.delegate = self
        
        signUpUserNameTextField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.signUpUserNameTextField {
            signUpPasswordTextField.becomeFirstResponder()
        } else {
            signUpUserMethod()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.signUpUserNameTextField {
            signUpUserNameTextField.resignFirstResponder()
        } else {
            signUpPasswordTextField.resignFirstResponder()
        }
        
        return true
        
    }
    
    //method to sign up user.
    func signUpUserMethod(){
        let user = PFUser()
        user.username = signUpUserNameTextField.text
        user.password = signUpPasswordTextField.text
        //user.email = "wyatt.endres@gmail.com"
        // other fields can be set just like with PFObject
        user["money"] = SignUpBonus
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                _ = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main")
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
            }
        }
    }
    
    //method to end user session (log out)
    func endUserSession(){
        PFUser.logOut()
        _ = PFUser.currentUser() // this will now be nil
    }
    
    
    
}
