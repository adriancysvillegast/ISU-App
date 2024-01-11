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

protocol DashBoardViewModelDelegate: AnyObject {
    func conectWithGoogle()
    func goToSignInView()
}

class DashBoardViewModel {
    
    // MARK: - Properties
    private var authManager: SignInFirebaseManager
    weak var delegate: DashBoardViewModelDelegate?
    private var signInGoogleManager: SignInGoogleManager?
    
    var ticketsArray: [TicketModelCell] = []
    
    var api_key: String = ProcessInfo.processInfo.environment["api_key"] ?? ""
    
    var isSignedInGoogle: Bool {
        return userAccessToken != nil
    }
    var isSignInFirebase: Bool {
        return authManager.isSignIn()
    }
    
    var userAccessToken: String? {
        return UserDefaults.standard.string(forKey: "userAccessToken")
    }
    
    var name: String? {
        return UserDefaults.standard.string(forKey: "name")
    }
    
    // MARK: - init
    
    init(
        authManager: SignInFirebaseManager = SignInFirebaseManager(),
        signInGoogleManager: SignInGoogleManager = SignInGoogleManager()
    ) {
        self.authManager = authManager
        self.signInGoogleManager = signInGoogleManager
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
    
    func getlastTicket() -> TicketModelCell? {
        return ticketsArray.first
    }
    
    
    // MARK: - Google sync
    func logInGoogle(vc: UIViewController) {
        signInGoogleManager?.logIn(vc: vc)
    }
    
    func showAlertToSignWithGoogle() {
        /*This funtion has the propuse to show a alert to make the user Log in with his\her account */
        if !isSignedInGoogle{
            delegate?.conectWithGoogle()
        }
    }
    
    func logOut() {
        let firebaseAccount = authManager.logOut()
        let googleAccount = signInGoogleManager?.logOutCleanData()
        
        signInGoogleManager?.logOut()
        if firebaseAccount, googleAccount == true  {
            self.delegate?.goToSignInView()
        }else {
            print("error")
        }
    }

}
