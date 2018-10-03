//
//  ViewController.swift
//  LoginModules
//
//  Created by Hardik Wason on 02/10/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper


class Login: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emai_txt: UITextField!
    @IBOutlet weak var pass_txt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        if let keychain = KeychainWrapper.standard.string(forKey: KEY_UID)
        {
            print("yo man \(String(describing: keychain))")
            performSegue(withIdentifier: "logintomain", sender: nil)
        }
    }
    
// User will Login Through the details filled during the Sign Up procedure.
    @IBAction func login_btn(_ sender: Any) {
        if emai_txt.text == "" || pass_txt.text == ""
        {
            let alert = UIAlertController(title: "Empty Fields", message: "Fields cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: emai_txt.text!, password: pass_txt.text!, completion: { (user, error) in
                if error == nil
                {
                    print("HD: Authenticated with Firebase dude")
                    if let user = user
                    {
                        let userData = ["provider":user.user.providerID]
                        self.completeSignIn(id: user.user.uid, userData: userData)
                    }
                } else
                {
                    let alert = UIAlertController(title: "Invalid Email/Password", message: "Please Enter Valid Details", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        }
    }

    // User will be Sign Up or Can do the Login with the help of facebook.
    @IBAction func fb_btn(_ sender: Any) {
        let fblogin = FBSDKLoginManager()
        fblogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil
            {
                print("HD: Unsuccessful Login in FB")
            } else if result?.isCancelled == true
            {
                print("HD: User cancelled Login in FB")
            } else {
                print("HD: Successful Login in FB")
                let credential = FacebookAuthProvider.credential(withAccessToken:FBSDKAccessToken.current().tokenString)
                self.firebase_auth(credential)
            }
        }
    }
    func firebase_auth(_ credential: AuthCredential)
    {
        Auth.auth().signInAndRetrieveData(with: credential) { (user,error) in
            if error != nil
            {
                print("HD: Unsuccessful Login in Firebase")
                let alert = UIAlertController(title: "Already Signed Up", message: "You have already Signed in through email Try Again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else
            {
                print("HD: Successful Login in Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.user.uid, userData: userData)
                }
            }
        }
    }
    
    
    func completeSignIn(id: String, userData:Dictionary<String,String>)
    {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "logintomain", sender: nil)
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





















