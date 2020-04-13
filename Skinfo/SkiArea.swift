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
    var trailCount: Int
    var N: Float
    var W: Float
    
    //------------------------------------------------------------------------------------------------
    
    init(name: String, trailCount: Int, N: Float, W: Float) {
        self.name = name
        self.trailCount = trailCount
        self.N = N
        self.W = W
        super.init()
    }
    
    //------------------------------------------------------------------------------------------------
    
    convenience init(random: Bool = false) {
        self.init(name: "Ski Area", trailCount: 100, N: 1.1, W: 2.2)
    }
    
    //------------------------------------------------------------------------------------------------
    
    
    
}

