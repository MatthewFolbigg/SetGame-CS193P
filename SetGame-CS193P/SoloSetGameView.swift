//
//  SoloSetGameView.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 06/06/2021.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGameViewModel
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            SetCardView(card: card, theme: game.cardTheme)
        }
    }
}

struct SetCardView: View {
    
    var card: SetCard
    var theme: CardTheme
    
    var objectColour: Color { theme.objectColour(feature: card.firstFeature) }
    var numberOfShapes: Int { theme.numberOfObjects(feature: card.secondFeature) }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
            VStack() {
                ForEach(0..<numberOfShapes) {  _ in
                    if card.thirdFeature == .One {
                        CardObjectShape(shapeFeature: card.fourthFeature).stroke()
                    } else if card.thirdFeature == .Two {
                        ZStack {
                            CardObjectShape(shapeFeature: card.fourthFeature)
                                .foregroundColor(objectColour.opacity(0.5))
                            CardObjectShape(shapeFeature: card.fourthFeature)
                                .stroke(lineWidth: 2)
                                .foregroundColor(objectColour)
                        }
                    } else if card.thirdFeature == .Three {
                        CardObjectShape(shapeFeature: card.fourthFeature)
                    }
                }
                .foregroundColor(objectColour)
            }
            .padding(8)
        }
    }
}

struct CardObjectShape: Shape {
    
    let shapeFeature: SetCard.Feature
    
    func path(in rect: CGRect) -> Path {
        if shapeFeature == .One {
            return Circle().path(in: rect)
        } else if shapeFeature == .Two {
            return Rectangle().path(in: rect)
        } else if shapeFeature == .Three {
            return Ellipse().path(in: rect)
        } else {
            return Path()
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SoloSetGameView(game: SoloSetGameViewModel())
    }
}
