//
//  SetCardDeck.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import Foundation

struct SetCardDeck {
    
    let cards: [SetCard]
    
    init() {
        var setCards: [SetCard] = []
        for shape in SetCard.Shape.allCases {
            for colour in SetCard.Colour.allCases {
                for number in SetCard.Number.allCases {
                    for shading in SetCard.Shading.allCases {
                        let id = (shape.rawValue * 1000) + (colour.rawValue * 100) + (number.rawValue * 10) + shading.rawValue
                        let card = SetCard(shape: shape, colour: colour, number: number, shading: shading, id: id)
                        setCards.append(card)
                    }
                }
            }
        }
        self.cards = setCards
    }
    
}
