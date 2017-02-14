//
//  AuthenticationService.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/13/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthenticationService {
    
    private static let _instance = AuthenticationService()
    
    static var instance: AuthenticationService {
        return _instance
    }
    
    func createUser(email: String, password: String, onComplete: Completion?) {
    
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.processFirebaseErrors(error: error! as NSError, onComplete: onComplete)
            } else {
                if user?.uid != nil {
                    
                    //Attempt to sign in user right away while creating an account
                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            // Sign in after account creationg resulted in a failure
                            self.processFirebaseErrors(error: error! as NSError, onComplete: onComplete)
                        } else {
                            // User sign in was successful - send back the user data
                            onComplete?(nil, user)
                        }
                    })
                }
            }
        })
    }
 
    
    func signin(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                // There is an error
                
                self.processFirebaseErrors(error: error as! NSError, onComplete: onComplete)
            } else {
                // No errors detected - aka signed in successfully
                onComplete?(nil, user)
                print("MOR: Sign In attempt was successful\n")
            }
        })
    }
    
    func signout() {
        do {
            try FIRAuth.auth()?.signOut()
            print("MOR: User has been Signed Out successfully")
        } catch {
            print("MOR: An error has occurred while attempting to sign out")
        }
    }
    
    private func processFirebaseErrors(error: NSError, onComplete: Completion?) {
        if let errorCode = FIRAuthErrorCode(rawValue: error._code) {
            switch errorCode {
            case .errorCodeUserNotFound:
                onComplete?("No account exists with the provided email.", nil)
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
