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
        self.model = SoloSetGameViewModel.newSoloSetGame()
        self.cardTheme = theme
    }
    
    var cards: [SetCard] { model.cards }
    var cardTheme: CardTheme
    
    static func newSoloSetGame() -> SetGame {
        SetGame()
    }

    //MARK: - Intents
    
    //MARK: - FOR TESTING WILL BE REMOVED FROM HERE
    func getThreeRandomCards() -> [SetCard] {
        let upper = Int.random(in: 50...(cards.count-1))
        let mid = upper - 20
        let lower = upper - 40
        return [cards[upper], cards[mid], cards[lower]]
    }
    
    func checkSet(cardOne: SetCard, cardTwo: SetCard, cardThree: SetCard) -> Bool {
        model.containsSet(cardOne: cardOne, cardTwo: cardTwo, cardThree: cardThree)
    }
    
    
    
    
}
