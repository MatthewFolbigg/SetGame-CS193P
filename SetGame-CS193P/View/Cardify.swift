//
//  Cardify.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 25/06/2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    let colour: Color
    let isSelected: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let lineWidth = geometry.size.height/(isSelected ? DrawingConstants.lineWidthModifier : DrawingConstants.selectedLineWidthModifier)
            ZStack() {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    .strokeBorder(lineWidth: lineWidth)
                    .background(colour.brightness(isSelected ? 0.3 : 0.5).clipShape(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)))
                content
                    .padding(geometry.size.height * 0.15)
            }
            
            .foregroundColor(colour)
            .scaleEffect(isSelected ?  DrawingConstants.selectedScale : 1 )
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidthModifier: CGFloat = 25
        static let selectedLineWidthModifier: CGFloat = 50
        static let selectedScale: CGFloat = 1.08
    }
}

extension View {
    func cardify(colour: Color, isSelected: Bool) -> some View {
        self.modifier(Cardify(colour: colour, isSelected: isSelected))
    }
}


