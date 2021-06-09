//
//  SoloSetGameView.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 06/06/2021.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGameViewModel
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.colour == .green {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.green)
                        .opacity(Double(card.number.rawValue)/3.0)
                    Text("\(card.shading.rawValue) \(card.shape.rawValue)")
                }
            }
            if card.colour == .purple {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.purple)
                        .opacity(Double(card.number.rawValue)/3.0)
                    Text("\(card.shading.rawValue) \(card.shape.rawValue)")
                }
            }
            if card.colour == .red {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                        .opacity(Double(card.number.rawValue)/3.0)
                    Text("\(card.shading.rawValue) \(card.shape.rawValue)")
                }
            }
        }
    }
}

struct TestItem: Identifiable {
    var id: Int
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SoloSetGameView(game: SoloSetGameViewModel())
    }
}
