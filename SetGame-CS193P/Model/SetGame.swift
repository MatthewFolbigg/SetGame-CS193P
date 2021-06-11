//
//  SetGame.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import Foundation

struct SetGame {
    
    private let cardDeck = SetCardDeck()
    var cards: [SetCard] { cardDeck.cards }
 
    
    func containsSet(cardOne: SetCard, cardTwo: SetCard, cardThree: SetCard) -> Bool {
        let featureOneIsSet = featuresAllowForSet(featureOne: cardOne.firstFeature, featureTwo: cardTwo.firstFeature, featureThree: cardThree.firstFeature)
        let featureTwoIsSet = featuresAllowForSet(featureOne: cardOne.secondFeature, featureTwo: cardTwo.secondFeature, featureThree: cardThree.secondFeature)
        let featureThreeIsSet = featuresAllowForSet(featureOne: cardOne.thirdFeature, featureTwo: cardTwo.thirdFeature, featureThree: cardThree.thirdFeature)
        let featureFourIsSet = featuresAllowForSet(featureOne: cardOne.fourthFeature, featureTwo: cardTwo.fourthFeature, featureThree: cardThree.fourthFeature)
        
        if featureOneIsSet && featureTwoIsSet && featureThreeIsSet && featureFourIsSet {
            return true
        } else {
            return false
        }
    }
    
    private func featuresAllowForSet(featureOne a: SetCard.Feature, featureTwo b: SetCard.Feature, featureThree c: SetCard.Feature) -> Bool {
        if (a == b) && (b == c) {
            return true
        } else if (a != b) && (b != c) && (a != c) {
            return true
        } else {
            return false
        }
    }
    
    
    
}
