//
//  SQLiteManager.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 8/1/24.
//

import Foundation
import SQLite
import SQLite3

final class SQLiteManager {
    /**
     
     Class to create the data base
     */
    // MARK: - Properties
    
    static let shared = SQLiteManager()
    
    var database : Connection?
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let fileUrl = documentDirectory.appending(component: "ticketList").appendingPathExtension("sqlite3")
            database = try Connection(fileUrl.path)
        } catch  {
            print("Creating connection to database error \(error)")
        }
        
    }
    
    
    // MARK: - Methods

    func createTable() {
        SQLiteCommands.createTable()
    }

}

