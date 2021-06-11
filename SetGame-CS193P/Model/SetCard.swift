//
//  SetCard.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import Foundation

struct SetCard: Identifiable {
    
    enum Feature: Int, CaseIterable {
        case One = 1
        case Two
        case Three
    }
    
    let firstFeature: Feature
    let secondFeature: Feature
    let thirdFeature: Feature
    let fourthFeature: Feature
    let id: Int
    
}
