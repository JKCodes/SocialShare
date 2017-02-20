//
//  Post.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/20/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    private var _user: User!
    private var _postTime: String!
    private var _postUrl: String!
    private var _postType: String!
    private var _caption: String!
    private var _likes: Int!
    private var _postId: String!
    private var _postRef: FIRDatabaseReference!
    
    var user: User {
        return _user
    }
    
    var postTime: String {
        return _postTime
    }
    
    var postUrl: String {
        return _postUrl
    }
    
    var caption: String  {
        get {
            return _caption
        } set {
            _caption = newValue
        }
    }
    
    var likes: Int {
        return _likes
    }
    
    var postId: String {
        return _postId
    }

    
    init(postId: String, postUrl: String, postType: StorageTypes, caption: String, user: User) {
        _user = user
        _postTime = "\(Date().timeIntervalSince1970)"
        _postUrl = postUrl
        _caption = caption
        _likes = 0
        _postId = postId
        _postType = postType.rawValue
        _postRef = DatabaseService.instance.postsRef.child(_postId)
    }
    
    mutating func adjustLikes(addLike: Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        _postRef.child("likes").setValue(_likes)
    }
}
