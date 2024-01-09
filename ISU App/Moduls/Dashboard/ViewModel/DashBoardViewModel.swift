//
//  DashBoardViewModel.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 6/1/24.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST
import GTMSessionFetcher
import FirebaseCore
import FirebaseAuth

class DashBoardViewModel {
    
    // MARK: - Properties
    private var authManager: UserValidateManager
    
    var ticketsArray: [TicketModelCell] = []
    
    var api_key: String = ProcessInfo.processInfo.environment["api_key"] ?? ""
    
    var isSignedIn: Bool {
        return userAccessToken != nil
    }
    
    var userAccessToken: String? {
        return UserDefaults.standard.string(forKey: "userAccessToken")
    }
    
    var idToken: String? {
        return UserDefaults.standard.string(forKey: "idToken")
    }
    
    var email: String? {
        return UserDefaults.standard.string(forKey: "email")
    }
    
    var name: String? {
        return UserDefaults.standard.string(forKey: "name")
    }
    
    // MARK: - init
    
    init(
        authManager: UserValidateManager = UserValidateManager()
    ) {
        self.authManager = authManager
    }
    // MARK: - Methods
    
    
    func conectToDB() {
        _ = SQLiteManager.shared
    }
    
    func getTickets() {
        
        ticketsArray = SQLiteCommands.presentRows() ?? []
    }
    
    func getTicketsCount() -> Int {
        
        return ticketsArray.count
    }
    
    func ticketForRowAt(index: Int) -> TicketModelCell {
        return ticketsArray[index]
    }
    
    func getlastTictek() -> TicketModelCell? {
        return ticketsArray.first
    }
    
    
    
    
    
    // MARK: - Google sync
    func logInGoogle(vc: UIViewController) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [unowned self] result, error in
          if error == nil {
            print("without error")
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }
            
//            print(user.profile?.name)
            saveDataUserGoogle(idToken: idToken, user: user)
          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
        }
        
    }
    
    func logOut() {
        authManager.logOut()
        logOutGoogle()
    }
    
    private func logOutGoogle() {
        UserDefaults().set(nil, forKey: "idToken")
        UserDefaults().set(nil, forKey: "userAccessToken")
        UserDefaults().set(nil, forKey: "email")
        UserDefaults().set(nil, forKey: "name")
    }
    
    
    // MARK: - Cache Data
    func saveDataUserGoogle(idToken: String, user: GIDGoogleUser) {
        UserDefaults().set(idToken, forKey: "idToken")
        UserDefaults().set(user.accessToken.tokenString, forKey: "userAccessToken")
        UserDefaults().set(user.profile?.email, forKey: "email")
        UserDefaults().set(user.profile?.name, forKey: "name")
        
    }
    
    
}
