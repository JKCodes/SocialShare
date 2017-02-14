//
//  AuthenticationService.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/13/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import Foundation
import FirebaseAuth

// typealiasing to make code below more readable
typealias Completion = (_ errorMsg: String?, _ data: AnyObject?) -> Void

class AuthenticationService {
    
    private static let _instance = AuthenticationService()
    
    static var instance: AuthenticationService {
        return _instance
    }
    
   /*
    func createUser(uid: String, data: AnyObject?) {
        
        DatabaseService.instance.saveUser(uid: uid, data: data)
    }
 
 */
    
    func login(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                // There is an error
                
                self.processFirebaseErrors(error: error as! NSError, onComplete: onComplete)
            } else {
                // No errors detected - aka signed in successfully
                onComplete?(nil, user)
                print("MOR: Log in attempt was successful\n")
            }
        })
    }
    
    func logout() {
        do {
            try FIRAuth.auth()?.signOut()
            print("MOR: User has been logged out successfully")
        } catch {
            print("MOR: An Error has occurred while attempting to sign out")
        }
    }
    
    private func processFirebaseErrors(error: NSError, onComplete: Completion?) {
        if let errorCode = FIRAuthErrorCode(rawValue: error._code) {
            switch errorCode {
            case .errorCodeUserNotFound:
                onComplete?("No account exists with the email. Create an account?", nil)
            case .errorCodeInvalidEmail, .errorCodeWrongPassword:
                onComplete?("Invalid Email Address/Password Combination", nil)
            case .errorCodeWeakPassword:
                onComplete?("Password must be at least 6 characters", nil)
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete?("Email is already in use", nil)
            default:
                onComplete?("There was a problem authenticating. Please try again", nil)
            }
        }
    }
    
}
