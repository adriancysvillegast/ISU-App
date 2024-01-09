//
//  NewTicketViewModel.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 7/1/24.
//

import Foundation
import CoreLocation

protocol NewTicketViewModelDelegate: AnyObject {
    func showAlert()
    func wasAdded()
    func errorAdding()
}

class NewTicketViewModel {
    
    // MARK: - Properties
    weak var delegate: NewTicketViewModelDelegate?
    private let locationManager =  CLLocationManager()
    private var validateManager: ValidationManager?
    
    private var nameAdded: Bool = false
    private var placeAdded: Bool = false
    private var dateAdded: Bool = false
    
    // MARK: - Init
    
    init(validateManager: ValidationManager = ValidationManager()) {
        self.validateManager = validateManager
    }
    
    // MARK: - Methods
    
    func validateData() -> Bool {
        if nameAdded && placeAdded && placeAdded {
            return true
        }else{
            delegate?.showAlert()
            return false
        }
    }
    
    func reviewInfo(cliente: String?, date: Date?, location: PlacesModal?) -> Bool {
        clientNameIsEmpty(name: cliente)
        validatePlace(place: location)
        validateDate(date: date)
       return validateData()
    }
    
    func createNewTicket(cliente: String?, date: Date?, location: PlacesModal?) {
        
        if reviewInfo(cliente: cliente, date: date, location: location){
//            add
            guard let name = cliente, let dateScheduled = date, let location = location else {
                print("algo anda mal")
                return
            }
            let newTicket = TicketModelCell(id: 0, name: name, placeName: location.name, placeLatitude: location.cordinate.latitude.datatypeValue, placeLongitude: location.cordinate.longitude.datatypeValue, dateScheduled: dateScheduled)
            createTable()
            saveTicket(ticket: newTicket)
        }else {
            
            print("error with values \(#function)")
        }
    }
    
    func createTable() {
        let db = SQLiteManager.shared
        db.createTable()
    }
    
    func saveTicket(ticket: TicketModelCell) {
        let addedTicket = SQLiteCommands.insertRow(ticket)
        
        if addedTicket == true{
            print("--------------")
            delegate?.wasAdded()
        }else {
            delegate?.errorAdding()
        }
    }
    
    // MARK: - Validation
    
    func clientNameIsEmpty(name: String?) {
        guard let name = name else {
            nameAdded = false
            return
        }
        if let _ = validateManager?.validateName(nameUser: name) {
            nameAdded = true
        }
    }
    
    func validatePlace(place: PlacesModal?) {
        guard let _ = place else {
            placeAdded = false
            return
        }
        placeAdded = true
    }
    
    func validateDate(date: Date?) {
        guard date != nil else {
            dateAdded = false
            return
        }
        dateAdded = true
    }
    
    
    
    deinit {
        print(" NewTicketViewModel without memory leak")
    }
    
}
