//
//  NewTicketViewModel.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 7/1/24.
//

import Foundation
import CoreLocation
import GoogleAPIClientForREST
import GoogleSignIn
import FirebaseCore

protocol NewTicketViewModelDelegate: AnyObject {
    func showAlert()
    func wasAdded(message: String)
    func errorAdding(message: String)
}

class NewTicketViewModel {
    
    // MARK: - Properties
    weak var delegate: NewTicketViewModelDelegate?
    private let locationManager = CLLocationManager()
    private var validateManager: ValidationManager?
    private let signGoogleManager: SignInGoogleManager?
    
//    let service = GTLRCalendarService()
    
    private var nameAdded: Bool = false
    private var placeAdded: Bool = false
    private var dateAdded: Bool = false
    

    // MARK: - Init
    
    init(validateManager: ValidationManager = ValidationManager(),
         signGoogleManager: SignInGoogleManager = SignInGoogleManager()
    ) {
        self.validateManager = validateManager
        self.signGoogleManager = signGoogleManager
    }
    
    // MARK: - Methods
    func createTable() {
        let db = SQLiteManager.shared
        db.createTable()
    }
    
    func createNewTicket(
        cliente: String?,
        date: Date?,
        location: PlacesModal?
    ) {
        
        if reviewInfo(cliente: cliente, date: date, location: location){
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
    
    
    func saveTicket(ticket: TicketModelCell) {
        let addedTicket = SQLiteCommands.insertRow(ticket)
        
        if addedTicket == true{
            delegate?.wasAdded(message: "The ticket was added")
        }else {
            delegate?.errorAdding(message: "Error trying to add the ticket")
        }
    }
    
    func addEventoToGoogleCalendar(
        vc: UIViewController,
        ticketValue: TicketModelCell,
        client : String,
        location : String,
        date: Date
    ) {

        /*I tried a lot but i couldn't add the tickets on google Calendar
         all of this process give me this error
         "Error adding event: Request had insufficient authentication scopes."
         
         i tried to add scopes but it wasn't enought, i could undertand the  documentation
         */
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration(clientID: clientID )
        GIDSignIn.sharedInstance.configuration = signInConfig
        
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self] result, error in
            if error != nil {
                print("errooooorrrr -> \(error)")
            }
            
            self?.addEventToCalendar(
                vc: vc,
                ticketValue: ticketValue,
                client : client,
                location : location,
                date: date)
        }
    }
    
    
    func addEventToCalendar(vc: UIViewController,ticketValue: TicketModelCell,
                            client : String,
                            location : String,
                            date: Date) {
        let service = GTLRCalendarService()
        service.authorizer = GIDSignIn.sharedInstance.currentUser?.fetcherAuthorizer

        let event = GTLRCalendar_Event()
        event.summary = client
        event.location = location
        event.start = buildDate(date: date)
        event.end = buildDate(date: date.addingTimeInterval(3600))// 1 hour later

        let query = GTLRCalendarQuery_EventsInsert.query(withObject: event, calendarId: "primary")
        service.executeQuery(query) { _, _, error in
            if let error = error {
                // Handle error
                print("Error adding event: \(error.localizedDescription)")
                return
            }
            self.saveTicket(ticket: ticketValue)
            // Event added successfully
            print("Event added to Google Calendar.")
        }
    }
    
    func buildDate(date: Date) -> GTLRCalendar_EventDateTime {
        let datetime = GTLRDateTime(date: date)
        let dateObject = GTLRCalendar_EventDateTime()
        dateObject.dateTime = datetime
        return dateObject
    }

    func updateTicket(oldTicket: TicketModelCell ,cliente: String?, date: Date?, location: PlacesModal?) {
        if reviewInfo(cliente: cliente, date: date, location: location){
            guard let name = cliente, let dateScheduled = date, let location = location else {
                return
            }
            
            let newValues = TicketModelCell(
                id: oldTicket.id,
                name: name,
                placeName: location.name,
                placeLatitude: location.cordinate.latitude.datatypeValue,
                placeLongitude: location.cordinate.longitude.datatypeValue,
                dateScheduled: dateScheduled)

            let updateSuccess = SQLiteCommands.updateRow(newValues)
            
            if updateSuccess == true {
                delegate?.wasAdded(message: "The ticket was updated")
            }else {
                delegate?.errorAdding(message: "Error trying to update the ticket")
            }
        }else {
            delegate?.errorAdding(message: "Error trying to update the ticket")
        }
    }
    
    // MARK: - Validation
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
