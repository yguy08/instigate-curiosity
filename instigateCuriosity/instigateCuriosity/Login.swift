//
//  Login.swift
//  instigateCuriosity
//
//  Created by Wyatt Endres on 1/24/16.
//  Copyright © 2016 Wyatt Endres. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts



class Login: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginUsernameTextField: UITextField!
    @IBOutlet weak var passwordUsernameTextField: UITextField!
    
    @IBOutlet weak var loginHeaderText: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        
        //give text field their delegates
        loginUsernameTextField.delegate = self
        passwordUsernameTextField.delegate = self
        
        //set loginUsername as first responder
        loginUsernameTextField.becomeFirstResponder()
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.loginUsernameTextField {
            passwordUsernameTextField.becomeFirstResponder()
        } else {
            loginUserMethod()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.loginUsernameTextField {
            loginUsernameTextField.resignFirstResponder()
        } else {
            passwordUsernameTextField.resignFirstResponder()
        }
        
        return true
        
    }
    
    //custom functions
    func loginUserMethod(){
        let username = loginUsernameTextField.text
        let userPassword = passwordUsernameTextField.text
        PFUser.logInWithUsernameInBackground(username!, password:userPassword!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main")
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
            } else {
                self.loginHeaderText.text = "💩"
                self.loginUsernameTextField.text = ""
                self.passwordUsernameTextField.text = ""
                self.loginUsernameTextField.becomeFirstResponder()
            
            }
        }
    }
    
    
    
}
