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
//        let path = Bundle.main.path(forResource: "db", ofType: "sqlite3")!
//        let db = try! Connection(path, readonly: true)
        
//        copyFilesFromBundleToDocumentsFolderWith(fileExtension: ".db")
        copyDatabaseIfNeeded()
        
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        let db = try! Connection("\(path)/skiAreaDBtest.db")
        
        let skiAreas = Table("skiAreas")
        
//        let name = Expression<String?>("name")
        
        let Name = Expression<String>("Name")
        
//        for skiArea in try! db.prepare(skiAreas.select(names)) {
//            print("id: \(skiAreas)")
//            print(names)
//            // id: 1, email: alice@mac.com
//        }
        
        let query = skiAreas.select(Name)
        let results = try! db.prepare(query)
        print(try! db.scalar("SELECT Name FROM skiAreas")!)

        for item in results{
            print(item)
        }
        
//        print(query)
        
//        print(names)
        
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
    
    func copyFilesFromBundleToDocumentsFolderWith(fileExtension: String) {
        if let resPath = Bundle.main.resourcePath {
            do {
                let dirContents = try FileManager.default.contentsOfDirectory(atPath: resPath)
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                let filteredFiles = dirContents.filter{ $0.contains(fileExtension)}
                for fileName in filteredFiles {
                    if let documentsURL = documentsURL {
                        let sourceURL = Bundle.main.bundleURL.appendingPathComponent(fileName)
                        let destURL = documentsURL.appendingPathComponent(fileName)
                        do { try FileManager.default.copyItem(at: sourceURL, to: destURL) } catch {}
                    }
                }
            } catch {
            }
        }
    }
    
    //------------------------------------------------------------------------------------------------
    
    init() {
        createItem()
    
    }
    
}
