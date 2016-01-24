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



class Information: UIViewController {
    
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    func logOutCurrentParseUser(){
        PFUser.logOutInBackground()
        _ = PFUser.currentUser()
    }
    
    
    
}
