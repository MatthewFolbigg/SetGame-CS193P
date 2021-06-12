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
    
    var cardTheme: CardTheme
    var currentCards: [SetCard] { model.dealtCards }
    
    //MARK: - Intents
    func dealFirstCards() {
        model.dealCards(12)
    }
    
    func dealMoreCards() {
        model.dealCards(3)
    }
    
    func chooseCard(_ card: SetCard) {
        model.choose(card: card)
    }
    
    func newGame() {
        self.model = SetGame()
    }
    
}
