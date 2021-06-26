//
//  CardThemes.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 11/06/2021.
//

import SwiftUI

protocol CardTheme {
    static func cardColour(for card: SetCard) -> Color
    static func numberOfObjects(on card: SetCard) -> Int
}

struct StandardCardTheme: CardTheme {
  
    static func cardColour(for card: SetCard) -> Color {
        switch card.firstFeature {
        case .One : return Color.red
        case .Two : return Color.purple
        case .Three : return Color.green
        }
    }
    
    static func numberOfObjects(on card: SetCard) -> Int {
        switch card.secondFeature {
        case .One : return 1
        case .Two : return 2
        case .Three : return 3
        }
    }
    
    struct cardShape: Shape {
        let card: SetCard
        func path(in rect: CGRect) -> Path {
            switch card.thirdFeature {
            case .One : return Diamond().path(in: rect)
            case .Two : return Rectangle().path(in: rect)
            case .Three : return Ellipse().path(in: rect)
            }
        }
    }
        
}
