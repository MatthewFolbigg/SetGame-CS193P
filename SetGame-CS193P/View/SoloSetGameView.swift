//
//  SoloSetGameView.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 06/06/2021.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGameViewModel
    @Namespace private var dealingNameSpace
    
    //MARK: - Main Body
    var body: some View {
        VStack {
            topBar
            gameView
            bottomBar
        }
    }
    
    //MARK: - Game View
    var gameView: some View {
        VStack {
            switch game.gameState {
            case .playing: dealtCardsView
            case .win: winMessage
            case .loose: looseMessage
            }
            deckAndDiscardSection
        }
    }
    
    var dealtCardsView: some View {
        AspectVGrid(items: game.dealtCards, aspectRatio: DrawingConstants.aspectRatio,  minItemWidth: 70, minColumns: 3) { card in
            CardView(card: card, cardTheme: game.cardTheme)
                .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        game.chooseCard(card)
                    }
                }
        }
    }
    
    var remainingDeckView: some View {
        ZStack {
            ForEach(game.cardDeck) { card in
                ZStack {
                    Color.clear
                        .cardify(colour: .black, isSelected: false)
                        .brightness(0.3)
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                        .frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
                        .onTapGesture {
                            if game.currentlySelectedIsSet == .yes {
                                withAnimation() {
                                    game.dealToReplace()
                                }
                            } else {
                                for i in 0..<3 {
                                    withAnimation(Animation.easeInOut(duration: 1).delay(Double(i)*0.2)) {
                                        game.dealACard()
                                    }
                                }
                            }
                        }
                }
                
            }
        }
    }
    
    var matchedPileView: some View {
        ZStack {
            ForEach(game.matchedCards) { card in
                CardView(card: card, cardTheme: game.cardTheme)
                    .frame(width: DrawingConstants.deckWidth, height: DrawingConstants.deckHeight)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
            }
        }
    }
    
    var deckAndDiscardSection: some View {
        HStack {
            Spacer()
            remainingDeckView
            matchedPileView
            Spacer()
        }
    }
    
    var winMessage: some View {
            Text("You Win!")
                .font(.title)
                .foregroundColor(.green)
    }
    
    var looseMessage: some View {
            Text("You Loose")
                .font(.title)
                .foregroundColor(.red)
    }
    
    //MARK: - Bars
    var topBar: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 5) {
            Text("Solo Set")
                .font(.title)
                .foregroundColor(.red)
            Text("Current Score: \(game.score)")
                .font(.subheadline)
            }
            Spacer()
            newGameButton
        }
        .padding([.top, .leading, .trailing])
    }
    
    var bottomBar: some View {
            VStack {
                Text("Cards Remaining: \(game.totalCardsRemaining)")
                Text("Sets Found: \(game.setsFound)")
            }.font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.top, 5.0)
    }
    
    //MARK: - Buttons
    var newGameButton: some View {
        Button { game.newGame() }
            label: { Text("New Game") }
    }
    
    //MARK: - Card View
    struct CardView: View {
        
        var card: SetCard
        var cardTheme: CardTheme
        
        var cardColour: Color { cardTheme.cardColour(for: card) }
        var numberOfShapes: Int { cardTheme.numberOfObjects(on: card) }
        
        var body: some View {
            GeometryReader { geometry in
                
                VStack() {
                    ForEach(0..<numberOfShapes, id: \.self) { shapeIndex in
                        Group {
                            switch card.fourthFeature {
                            case .One :
                                StandardCardTheme.cardShape(card: card)
                            case .Two :
                                StandardCardTheme.cardShape(card: card)
                                    .stroke(lineWidth: 3)
                            case .Three :
                                ZStack {
                                    StandardCardTheme.cardShape(card: card)
                                        .stroke(lineWidth: 3)
                                    StandardCardTheme.cardShape(card: card)
                                        .scaleEffect(0.4)
                                }
                            }
                        }
                        .frame(maxHeight: geometry.size.height/4)
                        .aspectRatio(4/2, contentMode: .fit)
                    }
                }
                .cardify(colour: cardColour, isSelected: card.isSelected)
            }
            .padding(.top, 2)
        }
    }
    
    //MARK: - Constants
    struct DrawingConstants {
        static let aspectRatio: CGFloat = 2/3
        static let deckHeight: CGFloat = 90
        static let deckWidth = deckHeight * aspectRatio
    }
    
}







//MARK: - Canvas Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SoloSetGameView(game: SoloSetGameViewModel(theme: StandardCardTheme()))
    }
}
