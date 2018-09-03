//
//  AuthService.swift
//  Vibe
//
//  Created by Allan Frederick on 7/26/18.
//  Copyright © 2018 Allan Frederick. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AuthService {
    
    // Authentication sign-in helper function
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        // User firebase sign-in
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
            // if the account was sucessfully logged in, you can get the user's account data from the result object that's passed to the callback method
            // If error, indicate the error
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            // Upon completion of signIn method, call on onSuccess
            onSuccess()
        })
    }
    
    // Authentication sign-up helper function
    static func signUp(name: String, username: String, email: String, password: String, phoneNumber: String, vibeStatus: Int, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        // Create User
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            // if the new account was sucessfully created, the user is signed in, and you can get the user's account data from the result object that's passed to the callback method
            // If error creating user, indicate the error
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            // If no error, add registered user to Firebase Database
            let uid = user?.user.uid
            // Points to root location of Firebase Storage
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("profile_image").child(uid!)
            // Pushes profile photo to Firebase Storage
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                // If error pushing, indicate error and return
                if error != nil {
                    print("error uploading image file to storage,\(String(describing: error?.localizedDescription))")
                    return
                }
                // If no error, get image as URL from Firebase Storage
                let profileImageURL = storageRef.downloadURL(completion: { (url, error) in
                    // If error getting URL, inidcate error
                    if error != nil {
                        print("error downloading image file,\(String(describing: error?.localizedDescription))")
                        
                    }
                    // If no error, convert URL to string format, then proceed to create database nodes
                    print("URL obtained")
                    guard let url = url?.absoluteString else {return}
                    self.pushUserInfo(profileImageURL: url, name: name, username: username, phoneNumber: phoneNumber, email: email, password: password, uid: uid!, vibeStatus: vibeStatus, onSuccess: onSuccess)
                    // If no error, continue to vibe page
                })
            })
        })
    }
    
    // Pushes user information to Firebase Database
    static func pushUserInfo(profileImageURL: String, name: String, username: String, phoneNumber: String, email: String, password: String, uid: String, vibeStatus: Int, onSuccess: @escaping () -> Void) {
        // Points to root location of Firebase Database
        let ref = Database.database().reference()
        // Create a "users" node
        let usersReference = ref.child("users")
        // Create a child node of user uid
        let newUserReference = usersReference.child(uid)
        // Create child nodes for each uid
        newUserReference.setValue(["name": name, "username": username, "phone number": phoneNumber, "email": email, "password": password, "profileImageURL": profileImageURL, "vibeStatus": vibeStatus])
        print("description: \(newUserReference.description())")
        // Upon completion of signUp method, call on onSuccess
        onSuccess()
    }
    
    // User profile

    
}
