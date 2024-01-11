//
//  SignInGoogleManager.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 10/1/24.
//

import Foundation
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import GoogleAPIClientForREST


final class SignInGoogleManager {
    // MARK: - Properties
    
    let scopes = [kGTLRAuthScopeCalendar]
    let service = GTLRCalendarService()
    
    private var userInfo: GIDGoogleUser?
    
    // MARK: - Methods
    
    func logOut() {
        GIDSignIn.sharedInstance.disconnect { error in
            print("\(#function) error--> \(error)")
        }
    }
    
    func logOutCleanData() -> Bool {
        UserDefaults().set(nil, forKey: "idToken")
        UserDefaults().set(nil, forKey: "userAccessToken")
        UserDefaults().set(nil, forKey: "email")
        UserDefaults().set(nil, forKey: "name")
        return true
    }
    
    func logIn(vc: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config

        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [unowned self] result, error in
          if error == nil {
            print("without error")
          }
            guard let userValue = result?.user,
                  let idToken = userValue.idToken?.tokenString else {
            return
          }
            userInfo = userValue
            saveDataUserGoogle(idToken: idToken, user: userValue)
          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: userValue.accessToken.tokenString)
        }
    }
    
    func saveDataUserGoogle(idToken: String, user: GIDGoogleUser) {
        UserDefaults().set(idToken, forKey: "idToken")
        UserDefaults().set(user.accessToken.tokenString, forKey: "userAccessToken")
        UserDefaults().set(user.profile?.email, forKey: "email")
        UserDefaults().set(user.profile?.name, forKey: "name")
    }
    
    
    // MARK: - Calendar
    
    func addToScheduled(
        query: GTLRCalendarQuery_EventsInsert,
        user: GIDGoogleUser,
        completion: @escaping (Bool) -> Void
    ) {

//        service.authorizer?.fetcherService.
        service.authorizer = user.fetcherAuthorizer

        service.executeQuery(query) { (ticket, object, error) in

            
            print("ticket: \(ticket)\n object: \(object)\n error: \(error)")
//            if error == nil {
//                completion(true)
//            } else {
//                print("error \(#function) -- \(error)")
//                completion(false)
//            }
        }
    }
    
    
    func getCurrentUser(complation: @escaping (GIDGoogleUser) -> Void){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            guard let userIn = user, error == nil else {
                return
            }
            complation(userIn)
        }
    }
    

}
