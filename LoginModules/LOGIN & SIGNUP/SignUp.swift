//
//  SignUp.swift
//  LoginModules
//
//  Created by Hardik Wason on 02/10/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignUp: UIViewController {

    @IBOutlet weak var name_txt: UITextField!
    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var pass_txt: UITextField!
    @IBOutlet weak var confirm_txt: UITextField!
    @IBOutlet weak var number_txt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let keychain = KeychainWrapper.standard.string(forKey: KEY_UID)
        {
            print("yo man \(String(describing: keychain))")
                 performSegue(withIdentifier: "gofeed", sender: nil)
        }
    }
    
    
    @IBAction func sign_up(_ sender: Any) {
        if name_txt.text == "" || email_txt.text == "" || pass_txt.text == "" || number_txt.text == ""
        {
            let alert = UIAlertController(title: "Empty Fields", message: "Fields cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if pass_txt.text != confirm_txt.text
        {
            let alert = UIAlertController(title: "Password do not match", message: "Please Enter the Valid Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
     else
        {
            Auth.auth().createUser(withEmail: email_txt.text!, password: pass_txt.text!, completion: { (user,error) in
                if error != nil
                {
                    print("HD:I am not getting any success dude")
                }
                else
                {
                    print("HD:I am getting that success i want")
                    if let user = user
                    {
                        let userData = ["name":self.name_txt.text!,"email":self.email_txt.text!,"password":self.pass_txt.text!,"number":self.number_txt.text!,"provider":user.user.providerID]
                        self.completeSignIn(id:user.user.uid, userData: userData as Dictionary<String, AnyObject>)
                    }
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData:Dictionary<String,AnyObject>)
    {
        DataService.ds.signUpDBuser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "gofeed", sender: nil)
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
