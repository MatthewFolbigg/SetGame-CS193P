//
//  SoloSetGameViewModel.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 09/06/2021.
//

import SwiftUI

class SoloSetGameViewModel: ObservableObject {
   
    @Published private var model: SetGame
    
    init() {
        self.model = SoloSetGameViewModel.newSoloSetGame()
    }
    
    var cards: [SetCard] { model.cards }
    var cardTheme: CardTheme = standardCardTheme()
        

    
    static func newSoloSetGame() -> SetGame {
        SetGame()
    }

    
    
}
