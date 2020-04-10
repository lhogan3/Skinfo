//
//  SkiArea.swift
//  Skinfo
//
//  Created by Maxwell Peck on 4/6/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation

class SkiArea: NSObject {
    var name: String
    
    //------------------------------------------------------------------------------------------------
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    //------------------------------------------------------------------------------------------------
    
    convenience init(random: Bool = false) {
        self.init(name: "Ski Area")
    }
    
    //------------------------------------------------------------------------------------------------
    
    
    
}

