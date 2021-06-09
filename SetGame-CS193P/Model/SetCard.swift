//
//  SetCard.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import Foundation

struct SetCard: Identifiable {
    
    enum Shape: Int, CaseIterable {
        case oval = 1
        case rectangle = 2
        case diamond = 3
    }
    
    enum Colour: Int, CaseIterable {
        case red = 1
        case purple = 2
        case green = 3
    }
    
    enum Number: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum Shading: Int, CaseIterable {
        case fill = 1
        case stripe = 2
        case outline = 3
    }
    
    let shape: Shape
    let colour: Colour
    let number: Number
    let shading: Shading
    let id: Int
    
}
