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
    
}
