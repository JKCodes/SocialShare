//
//  DatabaseService.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/13/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

let FIR_CHILD_USERS = "users"
let FIR_CHILD_IMAGES = "images"
let FIR_CHILD_VIDEOS = "videos"
let FIR_CHILD_PROFILE = "profile"
let FIR_CHILD_USERNAMES = "usernames"

class DatabaseService {
    private static let _instance = DatabaseService()
    
    static var instance: DatabaseService {
        return _instance
    }
    
    var rootRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var usersRef: FIRDatabaseReference {
        return rootRef.child(FIR_CHILD_USERS)
    }
    
    var rootStorageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    var imagesStorageRef: FIRStorageReference {
        return rootStorageRef.child(FIR_CHILD_IMAGES)
    }
    
    var videosStorageRef: FIRStorageReference {
        return rootStorageRef.child(FIR_CHILD_VIDEOS)
    }
    
    func isDuplicateUsername(for name: String, onCompletion: @escaping Completion) {
        
        rootRef.child(FIR_CHILD_USERNAMES).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(name) {
                print("MOR: Duplicate username detected")
                onCompletion("\(name) is not available. Please choose a different username", nil)
            } else {
                print("MOR: Username is unique")
                onCompletion(nil, nil)
            }
        })
    }
    
    func saveUser(with data: Dictionary<String, AnyObject>) {
        
        guard let email = data["email"] as? String, let username = data["username"] as? String else {
            print("MOR: Error loading profile data")
            return
        }
        
        let profile: Dictionary<String, AnyObject> = ["email": email as AnyObject, "username": username as AnyObject]
        rootRef.child(FIR_CHILD_USERS).child((FIRAuth.auth()?.currentUser?.uid)!).child(FIR_CHILD_PROFILE).setValue(profile)
        rootRef.child(FIR_CHILD_USERNAMES).child(username).setValue(UserStates.active.rawValue)
        print("MOR: User profile info has been saved successfully")
    }
}


