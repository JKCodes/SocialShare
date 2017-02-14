//
//  User.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/13/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import UIKit

struct User {
    private var _firstName: String
    private var _lastName: String
    private var _userName: String
    private var _uid: String
    
    var uid: String  {
        return _uid
    }
    
    var username: String {
        return _userName
    }
    
    var firstName: String {
        return _firstName
    }
    
    var lastName: String {
        return _lastName
    }
    
    init(uid: String, username: String, firstName: String, lastName: String) {
        _firstName = firstName
        _lastName = lastName
        _userName = username
        _uid = uid
    }
}
