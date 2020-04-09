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
        let newItem = SkiArea(name: "Ski Area")
        return newItem
    }
    
    //------------------------------------------------------------------------------------------------
    
}
