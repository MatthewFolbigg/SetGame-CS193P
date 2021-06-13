//
//  SetCardDeck.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import Foundation

struct SetCardDeck {
    
    static let allCards: [SetCard] = buildSetCardDeck()
    static var shuffledAllCards: [SetCard] { allCards.shuffled() }
    
    private static func buildTestDeck() -> [SetCard] {
        let a = SetCard(firstFeature: .One, secondFeature: .One, thirdFeature: .One, fourthFeature: .One, id: 1)
        let b = SetCard(firstFeature: .Two, secondFeature: .Two, thirdFeature: .Two, fourthFeature: .Two, id: 2)
        let c = SetCard(firstFeature: .Three, secondFeature: .Three, thirdFeature: .Three, fourthFeature: .Three, id: 3)
        let d = SetCard(firstFeature: .One, secondFeature: .One, thirdFeature: .Two, fourthFeature: .Two, id: 4)
        let e = SetCard(firstFeature: .Two, secondFeature: .One, thirdFeature: .Two, fourthFeature: .Two, id: 5)
        let f = SetCard(firstFeature: .Three, secondFeature: .One, thirdFeature: .Two, fourthFeature: .Two, id: 6)
        return [a, b, c, d, e, f]
    }
    
    private static func buildSetCardDeck() -> [SetCard] {
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
        return setCards
    }
    
}
