//
//  ValidationManager.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 6/1/24.
//

import Foundation

class ValidationManager {
    
    /* This class has the propose to make all the validations to have a correct email and password to create a account on this app */
    
    // MARK: - Properties
    
    
    // MARK: - Methods
    
    
    // MARK: - Sign Up
    func validateName(nameUser: String ) -> Bool {
        if nameUser.count > 1 {
            return true
        }else {
            return false
        }
    }
    
    func validateEmail(emailUser: String) -> Bool {
        let regularExpresion = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        
        if !predicate.evaluate(with: emailUser) {
            return false
        }else {
            return true
        }
    }
    
    func validatePassword(passwordUser: String) -> Bool {
        if contentDigit(value: passwordUser) &&
            contentLowerCase(value: passwordUser) &&
            contentUpperCase(value: passwordUser) &&
            contentSpecialCharacters(value: passwordUser) &&
            passwordUser.count >= 6 {
            return true
        }else {
            return false
        }
    }
    
    func validateNumber(numberUser: String) -> Bool {
        if contentDigit(value: numberUser) && numberUser.count == 10 {
            return true
        }else {
            return false
        }
    }
    
    func contentDigit(value: String) -> Bool{
        let regularExpresion = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }
    
    func contentLowerCase(value: String) -> Bool{
        let regularExpresion = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }
    
    func contentUpperCase(value: String) -> Bool{
        let regularExpresion = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }
    
    func contentSpecialCharacters(value: String) -> Bool{
        let regularExpresion = ".*[^A-Za-z0-9].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }
}
