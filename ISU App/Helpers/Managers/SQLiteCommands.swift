//
//  SQLiteCommands.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 8/1/24.
//

import Foundation
import SQLite
import SQLite3

class SQLiteCommands {
    // MARK: - Properties
       
    static var table = Table("ticket")
    
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let placeName = Expression<String>("placeName")
    static let placeLatitude = Expression<Double>("placeLatitude")
    static let placeLongitude = Expression<Double>("placeLongitude")
    static let dateScheduled = Expression<Date>("dateScheduled")
    
    // MARK: - Queries
    
    static func createTable() {
        guard let database =  SQLiteManager.shared.database else {
            print("Database connection error \(#function)")
            return
        }
        
        do {
            //ifNotExists is true to avoid create a table when already exist
            try database.run(table.create(ifNotExists: true, block: { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(placeName)
                table.column(placeLatitude)
                table.column(placeLongitude)
                table.column(dateScheduled)
            }))
            
        } catch  {
            print("Table Already exists \(error)")
        }
    }
    
    static func insertRow(_ ticket: TicketModelCell) -> Bool? {
        guard let database = SQLiteManager.shared.database else {
            print("Database connection error \(#function)")
            return nil
        }
        
        do {
            try database.run(table.insert(
                name <- ticket.name,
                placeName <- ticket.placeName,
                placeLatitude <- ticket.placeLatitude,
                placeLongitude <- ticket.placeLongitude,
                dateScheduled <- ticket.dateScheduled
            ))
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT{
            print("Inserted row Failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error{
            print("Insertion failed \(error)")
            return false
        }
    }
    
    
    static func presentRows() -> [TicketModelCell]? {
        guard let database =  SQLiteManager.shared.database else {
            print("Database connection error")
            return nil
        }
        var ticketsArray = [TicketModelCell]()
        
        table = table.order(id.desc)
        
        do {
            ticketsArray = try database.prepare(table).compactMap({
                TicketModelCell(id: $0[id], name: $0[name], placeName: $0[placeName], placeLatitude: $0[placeLatitude], placeLongitude: $0[placeLongitude], dateScheduled: $0[dateScheduled])
            })
//            print(ticketsArray)
        } catch  {
            print("show row error \(error)")
            
        }
        return ticketsArray
    }
    
    
    
}
