//
//  SoloSetGameView.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 06/06/2021.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGameViewModel
    
    //MARK: - Mian Body
    var body: some View {
        VStack {
            //MARK: Top ToolBar
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 5) {
                Text("Solo Set")
                    .font(.title)
                    .foregroundColor(.red)
                Text("Current Score: \(game.score)")
                    .font(.subheadline)
                }
                Spacer()
                newGameButton(game)
            }
            .padding([.top, .leading, .trailing])
            //MARK: Card View
            switch game.gameState {
            case .playing:
                AspectVGrid(items: game.currentCards, aspectRatio: 2/3,  minItemWidth: 70, minColumns: 3) { card in
                    CardView(card: card, theme: game.cardTheme, highlightColour: game.selectedHighlightColour)
                        .onTapGesture { game.chooseCard(card) }
                }
            case .win:
                Spacer()
                Text("You Win!")
                    .font(.title)
                    .foregroundColor(.green)
                Spacer()
            case .loose:
                Text("You Loose")
                    .font(.title)
                    .foregroundColor(.red)
            }
            //MARK: Bottom Toolbar
            //Spacer(minLength: 0)
            VStack(alignment: .center) {
                dealThreeCardsButton(game, disabled: game.deckIsEmpty)
                VStack {
                    Text("Cards Remaining: \(game.totalCardsRemaining)")
                    Text("Sets Found: \(game.setsFound)")
                }.font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 5.0)
            }
            .padding()
        }
    }
}

//MARK: - Buttons
@ViewBuilder func newGameButton(_ intents: SoloSetGameViewModel) -> some View {
    Button { intents.newGame() }
        label: { Text("New Game") }
}

@ViewBuilder func dealThreeCardsButton(_ intents: SoloSetGameViewModel, disabled: Bool) -> some View {
    let backgroundColour: Color = disabled ? .gray : .blue
    ZStack {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .foregroundColor(backgroundColour)
            .frame(width: 200, height: 50)
    Button {
        intents.dealMoreCards()
    } label: {
        Image(systemName: "rectangle.stack")
        if disabled {
            Text("Empty")
        } else {
            Text("Deal 3")
        }
    }
    .foregroundColor(.white)
    .disabled(disabled)
    }
}


//MARK: - Card View
struct CardView: View {
    var card: SetCard
    var theme: CardTheme
    var highlightColour: Color
    
    var objectColour: Color { theme.objectColour(feature: card.firstFeature) }
    var numberOfShapes: Int { theme.numberOfObjects(feature: card.secondFeature) }
    
    var body: some View {
        GeometryReader { geometry in
            let lineWidth = geometry.size.height/50
            if card.isSelected {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .strokeBorder(lineWidth: lineWidth*2)
                        .foregroundColor(highlightColour)
                        .background(objectColour.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 10)))
                    cardObjectSectionView(card, in: geometry.size)
                        .padding(geometry.size.height * 0.15)
                        .foregroundColor(objectColour)
                }
                .scaleEffect(1.08)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .strokeBorder(lineWidth: lineWidth)
                        .foregroundColor(objectColour)
                        .background(objectColour.opacity(0.15).clipShape(RoundedRectangle(cornerRadius: 10)))
                    cardObjectSectionView(card, in: geometry.size)
                        .padding(geometry.size.height * 0.15)
                        .foregroundColor(objectColour)
                }
            }
        }
        .padding(.top, 2)
    }
}

//MARK: - Card Objects
//TODO: This should be generic enough to take cards that use other content, for example an image instead of a shape
@ViewBuilder func cardObjectSectionView(_ card: SetCard, in size: CGSize) -> some View {
    let objectAspectRatio: CGFloat = 4/2
    let numberOfShapes = card.secondFeature.rawValue
    VStack() {
        CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
            .frame(maxHeight: size.height/4)
            .aspectRatio(objectAspectRatio, contentMode: .fit)
        if numberOfShapes > 1 {
            CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
                .frame(maxHeight: size.height/4)
                .aspectRatio(objectAspectRatio, contentMode: .fit)
        }
        if numberOfShapes > 2 {
            CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
                .frame(maxHeight: size.height/4)
                .aspectRatio(objectAspectRatio, contentMode: .fit)
        }
    }
}

struct CardObjectShapeView: View {
    let shapeFeature: SetCard.Feature
    let strokeFeature: SetCard.Feature

    var body: some View {
        if strokeFeature == .One {
            CardObjectShape(shapeFeature: shapeFeature)
        } else if strokeFeature == .Two {
            CardObjectShape(shapeFeature: shapeFeature)
                .stroke(lineWidth: 3)
        } else if strokeFeature == .Three {
            ZStack{
                CardObjectShape(shapeFeature: shapeFeature)
                    .stroke(lineWidth: 3)
                CardObjectShape(shapeFeature: shapeFeature)
                    .scaleEffect(0.4)
            }
        }
    }
    
    struct CardObjectShape: Shape {
        let shapeFeature: SetCard.Feature
        func path(in rect: CGRect) -> Path {
            if shapeFeature == .One {
                return Diamond().path(in: rect)
            } else if shapeFeature == .Two {
                return Rectangle().path(in: rect)
            } else if shapeFeature == .Three {
                return Ellipse().path(in: rect)
            } else {
                return Path()
            }
        }
    }

}





//MARK: - Canvas Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SoloSetGameView(game: SoloSetGameViewModel(theme: StandardCardTheme()))
    }
}
