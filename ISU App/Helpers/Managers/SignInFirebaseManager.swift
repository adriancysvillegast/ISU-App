//
//  UserValidateManager.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 6/1/24.
//

import Foundation
import FirebaseAuth

final class SignInFirebaseManager {
    
    /*
     This class has the propose of make all of the validations to log in, log out and validate if there is an account active 
     */
    
    // MARK: - Properties
    var userAccessToken: String? {
        return UserDefaults.standard.string(forKey: "userAccessToken")
    }
    
    // MARK: - Methods
    
    func isSignIn() -> Bool {
        if let _ = Auth.auth().currentUser?.email, userAccessToken != nil {
            return true
        }else {
           return false
        }
    }
    
    func logInSection(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(
            withEmail: email,
            password: password)
        { authResult, error in
            if error != nil {
                completion(false)
            }else {
                completion(true)
            }
        }
    }
    
    func logOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch  {
            return false
        }
    }
    
    
    func createNewUser(email: String,
                       password: String,
                       success: @escaping(Bool) -> Void) {
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { authResponse, error in
            
            guard let response = authResponse, error == nil else {
                success(false)
                return
            }
            success(true)
            print(response.user)
            
        }
    }
    
}
