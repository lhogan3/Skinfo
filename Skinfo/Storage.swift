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
    
    //------------------------------------------------------------------------------------------------
    
    func createItem() -> SkiArea {
        //This is all test code and will be replaced in the future when db is fully implemented
        
        //Copy skiArea db to documents folder stored directly on device that is running skinfo
        copyDatabaseIfNeeded()
        
        //Path to documents folder
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        //Connect to db in documents folder
        let db = try! Connection("\(path)/skiAreaDBtest.db")
        
        //Table named skiAreas in db
        let skiAreas = Table("skiAreas")
        
        //Create 'Expression' in order to be used to reference 'Name' column
        let Name = Expression<String>("Name")
        
        //Start query by selecting all ski area names
        let query = skiAreas.select(Name)
        
        //Execute query
        let results = try! db.prepare(query)
        
        //Print name of ski areas in db
        print(try! db.scalar("SELECT Name FROM skiAreas")!)

        //Another way to print a Row object
        for item in results{
            print(item)
        }
        
        let newItem = SkiArea(name: "Ski Area")
        return newItem
    }
    
    //------------------------------------------------------------------------------------------------
    
    func copyDatabaseIfNeeded() {
        // Move database file from bundle to documents folder
        
        let fileManager = FileManager.default
        
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("skiAreaDBtest.db")
    
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("skiAreaDBtest.db")
            
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
        createItem()
    }
    
}
