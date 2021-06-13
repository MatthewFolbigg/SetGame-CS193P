//
//  SetGame.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import Foundation

struct SetGame {
    
    private let allSetCards = SetCardDeck.shuffledAllCards
    
    private(set) var cardDeck: [SetCard]
    private(set) var dealtCards: [SetCard] = []
    private(set) var matchedCards: [SetCard] = []
    private(set) var currentScore: Int = 0
    
    var currentGameSate: gameState { currentGameState() }
    var foundSetPointGain: Int = 3
    var notASetPointDeduction: Int = 1
    
    init() {
        cardDeck = allSetCards
        dealCards(12)
    }
    
    enum gameState {
        case playing
        case win
        case loose
    }
    
    //MARK: - Deck Management
    private mutating func getCardFromDeck() -> SetCard? {
        if cardDeck.count > 0 {
            print("Card taken from deck")
            return cardDeck.removeFirst()
        } else {
            print("No cards remaing in deck")
            printDeckStatus()
            return nil
        }
    }
    
    mutating func dealCards(_ number: Int) {
        for _ in 0..<number {
            if let card = getCardFromDeck() {
                dealtCards.append(card)
            } else {
                return
            }
        }
    }
    
    mutating func dealToReplaceCardAt(index: Int) {
        dealtCards.remove(at: index)
        if let newCard = getCardFromDeck() {
            dealtCards.insert(newCard, at: index)
        }
    }
    
    mutating func shuffleRemainingCards() {
        cardDeck.shuffle()
    }
    
    private func printDeckStatus() {
        print("remainingInDeck: \(cardDeck.count) Dealt:\(dealtCards.count) Matched: \(matchedCards.count)")
    }
    
    private func indexFor(_ card: SetCard, inArray: [SetCard]) -> Int? {
        return inArray.firstIndex(where: { $0.id == card.id })
    }
    
    
    //MARK: - Card Selection
    private var selectedCards: [SetCard] { dealtCards.compactMap { $0.isSelected == true ? $0 : nil } }
    var currentSelectionIsSet: isASet { containsSet(cards: selectedCards) }
    
    mutating func choose(card: SetCard) {
        guard let newSelectionIndex = indexFor(card, inArray: dealtCards) else { return }
        switch containsSet(cards: selectedCards) {
        case .notEnoughCards:
            dealtCards[newSelectionIndex].isSelected.toggle()
        case .yes:
            handelSet()
        case .no:
            toggleSelection(selectedCards)
            dealtCards[newSelectionIndex].isSelected.toggle()
            decreaseScore()
        }
    }
    
    private mutating func toggleSelection(_ cards: [SetCard]) {
        for card in cards {
            guard let index = indexFor(card, inArray: dealtCards) else { return }
            dealtCards[index].isSelected.toggle()
        }
    }
    
    private mutating func replaceSelectionWithNewCards() {
        for card in selectedCards {
            guard let index = indexFor(card, inArray: dealtCards) else { return }
            dealtCards.remove(at: index)
            matchedCards.append(card)
            if let card = getCardFromDeck() {
                dealtCards.insert(card, at: index)
            }
        }
    }
    
    //MARK: - SET Checking
    enum isASet {
        case yes
        case no
        case notEnoughCards
    }
    
    mutating func handelSet() {
        replaceSelectionWithNewCards()
        increaseScore()
    }
  
    private func containsSet(cards: [SetCard]) -> isASet {
        if cards.count != 3  { return .notEnoughCards } //Not enough or too many cards for a set
        let firstFeatures: [SetCard.Feature] = cards.map( { $0.firstFeature } )
        let secondFeatures: [SetCard.Feature] = cards.map( { $0.secondFeature } )
        let thirdFeatures: [SetCard.Feature] = cards.map( { $0.thirdFeature } )
        let fourthFeatures: [SetCard.Feature] = cards.map( { $0.fourthFeature } )
        let featureSets = [firstFeatures, secondFeatures, thirdFeatures, fourthFeatures]
        for featureSet in featureSets {
            if !featuresAllowForSet(a: featureSet[0], b: featureSet[1], c: featureSet[2]) {
                return .no
            }
        }
        return .yes
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
    
    //MARK: - Scoring
    
    func currentGameState() -> gameState {
        if cardDeck.isEmpty && dealtCards.count == 3 && containsSet(cards: selectedCards) == .yes {
            return .win
        } else {
            return .playing
        }
    }
    
    mutating func increaseScore() {
        currentScore += foundSetPointGain
    }
    
    mutating func decreaseScore() {
        currentScore -= notASetPointDeduction
    }
    
}
