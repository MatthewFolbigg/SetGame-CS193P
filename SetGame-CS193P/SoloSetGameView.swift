//
//  SoloSetGameView.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 06/06/2021.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGameViewModel
    
    @State var currentCards: [SetCard] = [] //TODO: Removed this. Should be handeled in the model
    
    //MARK: - Body
    var body: some View {
        VStack {
            AspectVGrid(items: currentCards, aspectRatio: 2/3) { card in
                CardView(card: card, theme: game.cardTheme)
            }
            Spacer()
            VStack {
                //TODO: Button functionality is for testing, this check shouldnt be in the view. It will be called in the mdoel via card selection intent
                Button("This is a Set!") {
                    print("Checking....")
                    if currentCards.count == 3 {
                        let check = game.checkSet(cardOne: currentCards[2], cardTwo: currentCards[1], cardThree: currentCards[0])
                        if check {
                            print("These cards are a SET!")
                        } else {
                            print("Nope")
                        }
                        
                    }
                }
                .padding(.bottom, 5.0)
                Button("New cards") {
                    print("New cards please")
                    currentCards = game.getThreeRandomCards()
                }
            }
            .padding()
        }
    }
}




//MARK: - Card Views
struct CardView: View {
    var card: SetCard
    var theme: CardTheme
    
    var objectColour: Color { theme.objectColour(feature: card.firstFeature) }
    var numberOfShapes: Int { theme.numberOfObjects(feature: card.secondFeature) }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(lineWidth: 2)
            VStack() {
                    CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
                if numberOfShapes > 1 {
                    CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
                }
                if numberOfShapes > 2 {
                    CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
                }
            }
            .foregroundColor(objectColour)
            .padding(30)
        }
    }
}

//TODO: This should be generic enough to take cards that use other content, for example an image instead of a shape
struct CardObjectShapeView: View {
    let shapeFeature: SetCard.Feature
    let strokeFeature: SetCard.Feature
    
    var body: some View {
        if strokeFeature == .One {
            CardObjectShape(shapeFeature: shapeFeature)
        } else if strokeFeature == .Two {
            CardObjectShape(shapeFeature: shapeFeature)
                .stroke()
        } else if strokeFeature == .Three {
            ZStack{
                CardObjectShape(shapeFeature: shapeFeature)
                    .opacity(0.5)
                CardObjectShape(shapeFeature: shapeFeature)
                    .stroke(lineWidth: 5)
            }
        }
    }
    
    struct CardObjectShape: Shape {
        let shapeFeature: SetCard.Feature
        func path(in rect: CGRect) -> Path {
            if shapeFeature == .One {
                return Circle().path(in: rect)
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
