//
//  CardThemes.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 11/06/2021.
//

import SwiftUI

protocol CardTheme {
    func objectColour(feature: SetCard.Feature) -> Color
    func numberOfObjects(feature: SetCard.Feature) -> Int
}

struct standardCardTheme: CardTheme {
        
    func objectColour(feature: SetCard.Feature) -> Color {
        switch feature {
        case .One : return Color.red
        case .Two : return Color.purple
        case .Three : return Color.green
        }
    }
    
    func numberOfObjects(feature: SetCard.Feature) -> Int {
        switch feature {
        case .One : return 1
        case .Two : return 2
        case .Three : return 3
        }
    }
    
}
