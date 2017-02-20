//
//  StorageService.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/20/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

let FIR_CHILD_PROFILEIMG = "profile"
let FIR_CHILD_IMAGES = "images"
let FIR_CHILD_VIDEOS = "videos"

class StorageService {

    private static let _instance = StorageService()
    
    static var instance: StorageService {
        return _instance
    }
    
    var rootRef: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: "gs://instaclone-613b6.appspot.com")
    }
    
    var imagesRef: FIRStorageReference {
        return rootRef.child(FIR_CHILD_IMAGES)
    }
    
    var videosRef: FIRStorageReference {
        return rootRef.child(FIR_CHILD_VIDEOS)
    }
    
    var profileRef: FIRStorageReference {
        return rootRef.child(FIR_CHILD_PROFILEIMG)
    }
    
    func uploadToStorage(type: StorageTypes, url: String, onComplete: @escaping Completion) {
        
        let ref: FIRStorageReference
        
        // Sets up the correct storage ref depending on the passed in StorageTypes value
        // For both privacy and uniqueness, the name of the file is randomly generated
        switch type {
        case .profile:
            ref = profileRef.child("\(NSUUID().uuidString).png")
            break
        case .image:
            ref = imagesRef.child("\(NSUUID().uuidString).jpg")
            break
        case .video:
            ref = videosRef.child("\(NSUUID().uuidString)\(url)")
            break
        }
        
        
        // Local file on the device
        let localFile = URL(string: url)!
        
        // Upload the file to the path
        let uploadTask = ref.putFile(localFile, metadata: nil)
        
        uploadTask.observe(.progress) { snapshot in
            // Upload progress.. to be used in future update of the app
            // let percentComplete = Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount) * 100.0
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload was successful
            onComplete(nil, nil)
        }
        
        uploadTask.observe(.failure) { snapshot in
            // An error has occurred
            
            if let error = snapshot.error as? NSError {
                switch (FIRStorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    print("MOR: File does not exist")
                    break
                case .unauthorized:
                    print("MOR: Permission error")
                    break
                case .cancelled:
                    print("MOR: User canceled the upload")
                    break
                case .downloadSizeExceeded:
                    print("MOR: Download size too big")
                    break
                default:
                    // This will cover the rest of the error codes
                    print("MOR: Unexpected error has occurred")
                }
            }
        }
    }
    
}

