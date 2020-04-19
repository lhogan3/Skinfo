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
    var hours: String
    var address: String
    var price: String
    
    //------------------------------------------------------------------------------------------------
    
    init(name: String, trailCount: Int, N: Float, W: Float, hours: String, address: String, price: String) {
        self.name = name
        self.trailCount = trailCount
        self.N = N
        self.W = W
        self.hours = hours
        self.address = address
        self.price = price
        super.init()
    }
    
    //------------------------------------------------------------------------------------------------
    
    convenience init(random: Bool = false) {
        self.init(name: "0", trailCount: 0, N: 0, W: 0, hours: "0", address: "0", price: "0")
    }
    
    //------------------------------------------------------------------------------------------------
    
    
    
}

