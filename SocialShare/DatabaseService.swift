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

let FIR_CHILD_USERS = "users"
let FIR_CHILD_IMAGES = "images"
let FIR_CHILD_VIDEOS = "videos"
let FIR_CHILD_PROFILE = "profile"

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
    
    func saveUser(uid: String, data: Dictionary<String, AnyObject>) {
        
        guard let firstName = data["firstName"] as? String, let lastName = data["lastName"] as? String, let username = data["username"] as? String else {
            print("Error loading profile data")
            return
        }
            let profile: Dictionary<String, AnyObject> = ["firstName": firstName as AnyObject, "lastName": lastName as AnyObject, "username": username as AnyObject]
            rootRef.child(FIR_CHILD_USERS).child(uid).child(FIR_CHILD_PROFILE).setValue(profile)
            print("MOR: User profile info has been saved successfully")
    }
}


