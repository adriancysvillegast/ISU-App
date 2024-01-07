//
//  LogInViewModel.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 5/1/24.
//

import Foundation
protocol LogInViewModelDelegate: AnyObject {
    func activateButton()
    func inactiveButton()
    func goToDashBoard()
    func showError()
    
    
}

class LogInViewModel {
    // MARK: - Properties
    private var validationManager: ValidationManager
    private var authManager: UserValidateManager
    
    weak var delegate: LogInViewModelDelegate?
    
    
    private var emailSuccess: Bool = false
    private var passwordSuccess: Bool = false
    
    // MARK: - init
    
    init(
        validationManager: ValidationManager = ValidationManager(),
        authManager: UserValidateManager = UserValidateManager()
    ) {
        self.validationManager = validationManager
        self.authManager = authManager
    }
    
    // MARK: - Methods
    
    func logIn(email: String?, password: String?) {
        //in this point neither email or password are empty 
        authManager.logInSection(email: email!, password: password!) { [weak self] success in
            success ? self?.delegate?.goToDashBoard() : self?.delegate?.showError()
            print("success --> \(success)")
        }
    }
    
    func validateTextField() {
        //activate button logIn with a delegate
        if emailSuccess && passwordSuccess {
            delegate?.activateButton()
        }else {
            delegate?.inactiveButton()
        }
    }
    
    func validatePassword(password: String?) {
        //Review if the textField is empty or not
        guard let password = password else {
            passwordSuccess = false
            return
        }
        
        if password.count > 0 {
            passwordSuccess = true
        }else {
            passwordSuccess = false
        }
        validateTextField()
    }
    
    func validateEmail(emailUser: String?) {
        //Review if the textField is empty or not
        guard let email = emailUser else {
            emailSuccess = false
            return
        }
        
        if validationManager.validateEmail(emailUser: email) {
            emailSuccess = true
        }else {
            emailSuccess = false
        }
        
        validateTextField()
    }
    
    
    
    
    deinit {
        print("LogInViewModel - Without Memory leaks")
    }
}
