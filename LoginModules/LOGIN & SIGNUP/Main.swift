//
//  Main.swift
//  LoginModules
//
//  Created by Hardik Wason on 02/10/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit
import  Firebase
import SwiftKeychainWrapper
import FBSDKLoginKit

class Main: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Logout_btn(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        let manager = FBSDKLoginManager()
        manager.logOut()
        performSegue(withIdentifier: "gologin", sender: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // It is use to hide the keyboard by just tapping anywhere on the screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // Change the Status Bar Style into White Color.
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return.lightContent
    }
}
