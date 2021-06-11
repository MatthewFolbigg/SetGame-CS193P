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
        for firstfFeature in SetCard.Feature.allCases {
            for secondFeature in SetCard.Feature.allCases {
                for thirdFeature in SetCard.Feature.allCases {
                    for fourthFeature in SetCard.Feature.allCases {
                        let id = (firstfFeature.rawValue * 1000) + (secondFeature.rawValue * 100) + (thirdFeature.rawValue * 10) + fourthFeature.rawValue
                        let card = SetCard(firstFeature: firstfFeature, secondFeature: secondFeature, thirdFeature: thirdFeature, fourthFeature: fourthFeature, id: id)
                        setCards.append(card)
                    }
                }
            }
        }
        self.cards = setCards
    }
    
}
