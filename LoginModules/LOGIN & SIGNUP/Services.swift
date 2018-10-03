//
//  Services.swift
//  LoginModules
//
//  Created by Hardik Wason on 02/10/18.
//  Copyright © 2018 Hardik Wason. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("Users")
    
    var REF_BASE: DatabaseReference
    {
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference
    {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String,userData: Dictionary<String, String>)
    {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func signUpDBuser(uid: String,userData: Dictionary<String,AnyObject>)
    {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
