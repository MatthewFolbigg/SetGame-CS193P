//
//  SetGame.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import Foundation

struct SetGame {
    
    private let allSetCards = SetCardDeck.shuffledAllCards
    
    private var cardDeck: [SetCard]
    private(set) var dealtCards: [SetCard] = []
    private(set) var matchedCards: [SetCard] = []
    
    init() {
        cardDeck = allSetCards
        dealCards(12)
    }
    
    mutating func dealCards(_ number: Int) {
        let numberToDeal = number < cardDeck.count ? number : cardDeck.count
        for _ in 0..<numberToDeal {
            let card = cardDeck.removeFirst()
            dealtCards.append(card)
        }
        if cardDeck.count == 0 {
            print("No more cards in deck")
        }
    }
    
    mutating func shuffleRemainingCards() {
        cardDeck.shuffle()
    }
    
    mutating func choose(card: SetCard) {
        guard let cardIndex = indexFor(card, inArray: dealtCards) else { return }
        dealtCards[cardIndex].isSelected.toggle()
        let selectedCards = dealtCards.compactMap { $0.isSelected == true ? $0 : nil }
        print(selectedCards.count)
        if selectedCards.count == 3 {
            handleSelectedCards(selectedCards)
        }
    }
    
    private mutating func handleSelectedCards(_ cards: [SetCard]) {
        if containsSet(cards: cards) {
            print("++ Thats a Set!")
            for card in cards {
                guard let index = indexFor(card, inArray: dealtCards) else { return }
                dealtCards.remove(at: index)
                dealtCards.insert(cardDeck.removeFirst(), at: index)
                matchedCards.append(card)
            }
        } else {
            print("-- Not a Set")
            for card in cards {
                guard let index = indexFor(card, inArray: dealtCards) else { return }
                dealtCards[index].isSelected = false
            }
        }
        print("remainingInDeck: \(cardDeck.count) Dealt:\(dealtCards.count) Matched: \(matchedCards.count)")
    }
    
    func indexFor(_ card: SetCard, inArray: [SetCard]) -> Int? {
        return inArray.firstIndex(where: { $0.id == card.id })
    }
    
  
    private func containsSet(cards: [SetCard]) -> Bool {
        if cards.count != 3  { return false } //Not enough or too many cards for a set
        let firstFeatures: [SetCard.Feature] = cards.map( { $0.firstFeature } )
        let secondFeatures: [SetCard.Feature] = cards.map( { $0.secondFeature } )
        let thirdFeatures: [SetCard.Feature] = cards.map( { $0.thirdFeature } )
        let fourthFeatures: [SetCard.Feature] = cards.map( { $0.fourthFeature } )
        let featureSets = [firstFeatures, secondFeatures, thirdFeatures, fourthFeatures]
        for featureSet in featureSets {
            if !featuresAllowForSet(a: featureSet[0], b: featureSet[1], c: featureSet[2]) {
                return false
            }
        }
        return true
    }
        
    private func featuresAllowForSet(a: SetCard.Feature, b: SetCard.Feature, c: SetCard.Feature) -> Bool {
        if (a == b) && (b == c) {
            return true
        } else if (a != b) && (b != c) && (a != c) {
            return true
        } else {
            return false
        }
    }
    
    
    
}
