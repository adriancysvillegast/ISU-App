//
//  DashBoardViewModel.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 6/1/24.
//

import Foundation

class DashBoardViewModel {
    
    // MARK: - Properties
    private var authManager: UserValidateManager
    
    // MARK: - init
    
    init(
        authManager: UserValidateManager = UserValidateManager()
    ) {
        self.authManager = authManager
    }
    // MARK: - Methods
    
    func logOut() {
        authManager.logOut()
    }
}
