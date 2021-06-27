//
//  SoloSetGameViewModel.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import SwiftUI

class SoloSetGameViewModel: ObservableObject {
   
    @Published private var model: SetGame
    
    init(theme: CardTheme) {
        self.model = SetGame()
        self.cardTheme = theme
    }
    
    private(set) var cardTheme: CardTheme
    
    var score: Int { model.currentScore }
    var gameState: SetGame.gameState { model.currentGameSate }
    
    var dealtCards: [SetCard] { model.dealtCards }
    var cardDeck: [SetCard] { model.cardDeck }
    var matchedCards: [SetCard] { model.matchedCards }
    
    var currentlySelectedIsSet: SetGame.isASet { model.currentSelectionIsSet }
    var totalCardsRemaining: Int { model.dealtCards.count + model.cardDeck.count }
    var setsFound: Int { model.matchedCards.count/3 }
    var deckIsEmpty: Bool { model.cardDeck.isEmpty }
    
    var selectedHighlightColour: Color {
        switch currentlySelectedIsSet {
        case .yes: return Color.green
        case .no: return Color.red
        case .notEnoughCards: return Color.blue
        }
    }
    
    //MARK: - Intents
    func dealFirstCards() {
        model.dealCards(12)
    }
    
    func dealThreeCards() {
        model.dealCards(3)
    }
    
    func dealACard() {
        model.dealCards(1)
    }
    
    func dealToReplace() {
        model.dealToReplaceSet()
    }
    
    func chooseCard(_ card: SetCard) {
        model.choose(card: card)
    }
    
    func newGame() {
        self.model = SetGame()
    }
    
}
