//
//  Storage.swift
//  Skinfo
//
//  Created by Maxwell Peck on 4/9/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation
import SQLite

class Storage {

    //Field Value: Array of all SkiArea objects (To be referenced in MasterViewController.swift)
    var allSkiAreas = [SkiArea]()
    
    //Database name:
    let databaseName = "SSCskiAreas2.db"
    
    //------------------------------------------------------------------------------------------------
    
    func populateArray() {
        //This is all test code and will be replaced in the future when db is fully implemented
        
        //Copy skiArea db to documents folder stored directly on host device if not already there
        copyDBtoDocs()
        
        //Connect to database
        let db = connectToDB()
        
        //Table named skiAreas in db
        let skiAreas = Table("skiAreas")
        
        //Create 'Expressions' in order to reference all column labels in queries
        let Name = Expression<String>("Name")
        let Trails = Expression<Int>("Trails")
        let N = Expression<String>("N")
        let W = Expression<String>("W")
        let Hours = Expression<String>("Hours")
        let Address = Expression<String>("Address")
        let Ticket_Price = Expression<String>("Ticket Price")
        
        //Number of entries in DB
        let numSkiAreas = try! db.scalar(skiAreas.count)
        
        //Loop same number of times as ski area entries in the DB
        for i in 1...numSkiAreas {
            
            //Start query by selecting row by index (rowid)
            let query = skiAreas.select(*).filter(rowid == Int64(i))
            
            //Execute query
            let resultsArr = Array(try! db.prepare(query))
            
            //Only one entry is needed at a time, so index 0 will return desired Row object:
            let result = resultsArr[0]
            
            //Add new SkiArea object to allSkiAreas array for later data maniulation and display
            allSkiAreas.append(SkiArea(name: result[Name], trailCount: result[Trails], N: Float(result[N])!, W: Float(result[W])!, hours: result[Hours], address: result[Address], price: result[Ticket_Price]))
        }
    }
    
    //------------------------------------------------------------------------------------------------
    
    func connectToDB() -> Connection {
    
        //Path to documents folder
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        //Connect to db in documents folder
        let db = try! Connection("\(path)/\(databaseName)")
        return db
    }
    
    //------------------------------------------------------------------------------------------------
    
    func copyDBtoDocs() {
        // Move database file from bundle to documents folder
        
        let fileManager = FileManager.default
        
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(databaseName)
    
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent(databaseName)
            
            do {
                  try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
                  } catch let error as NSError {
                    print("Couldn't copy file to final location! Error:\(error.description)")
            }

        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
    }
    
    //------------------------------------------------------------------------------------------------
    
    init() {
        populateArray()
    }
    
}
