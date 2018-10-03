//
//  Reset.swift
//  LoginModules
//
//  Created by Hardik Wason on 02/10/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit
import Firebase
class Reset: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var email_text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset_btn(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: email_text.text!) { (error) in
            if error == nil {
                print("Congo you are good man with these stuff")
                let alert = UIAlertController(title: "Reset Password", message: "Reset Password is sent to you", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                let alert = UIAlertController(title: "Reset Password", message: "Invalid Email Address", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
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
