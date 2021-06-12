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
        
        VStack(alignment: .trailing) {
            //MARK: Top ToolBar
            Button { game.newGame() }
                label: {
                    HStack{
                        //Image(systemName: "circle.circle")
                        Text("New Game")
                    }
                }
                .padding()
            
            //MARK: Card View
            AspectVGrid(items: game.currentCards, aspectRatio: 2/3) { card in
                CardView(card: card, theme: game.cardTheme)
                    .onTapGesture { game.chooseCard(card) }
            }
            //MARK: Bottom Toolbar
            Spacer(minLength: 0)
            HStack(alignment: .center) {
                Spacer()
                Button {
                    print("New cards please")
                    game.dealMoreCards()
                } label: {
                    Image(systemName: "rectangle.stack")
                    Text("Deal 3")
                }
                Spacer()
            }
            
            .padding()
        }
    }
    
}




//MARK: - Card View
struct CardView: View {
    var card: SetCard
    var theme: CardTheme
    var objectAspectRatio: CGFloat = 4/2
    
    var objectColour: Color { theme.objectColour(feature: card.firstFeature) }
    var numberOfShapes: Int { theme.numberOfObjects(feature: card.secondFeature) }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isSelected {
                    RoundedRectangle(cornerRadius: 7)
                        .strokeBorder(lineWidth: 5)
                        .scaleEffect(1.05)
                        .foregroundColor(.blue)
                        .background(objectColour.opacity(0.05).clipShape(RoundedRectangle(cornerRadius: 10)))
                    
                } else {
                    RoundedRectangle(cornerRadius: 7)
                        .strokeBorder(lineWidth: 2)
                        .foregroundColor(.black)
                        .background(objectColour.opacity(0.05).clipShape(RoundedRectangle(cornerRadius: 10)))
                }
                VStack() {
                    CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
                        .frame(maxHeight: geometry.size.height/4)
                        .aspectRatio(objectAspectRatio, contentMode: .fit)
                    if numberOfShapes > 1 {
                        CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
                            .frame(maxHeight: geometry.size.height/4)
                            .aspectRatio(objectAspectRatio, contentMode: .fit)
                    }
                    if numberOfShapes > 2 {
                        CardObjectShapeView(shapeFeature: card.thirdFeature, strokeFeature: card.fourthFeature)
                            .frame(maxHeight: geometry.size.height/4)
                            .aspectRatio(objectAspectRatio, contentMode: .fit)
                    }
                }
                .padding(geometry.size.height * 0.15)
                
                .foregroundColor(objectColour)
            }
        }
        
    }
}

//MARK: - Card Objects
//TODO: This should be generic enough to take cards that use other content, for example an image instead of a shape
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
                    .opacity(0.4)
                CardObjectShape(shapeFeature: shapeFeature)
                    .stroke(lineWidth: 5)
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
    
    struct Diamond: Shape {
        func path(in rect: CGRect) -> Path {
            let heightRadius = rect.height/2
            let widthRadius = rect.width/2
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let top = CGPoint(x: center.x, y: (center.y + heightRadius))
            let bot = CGPoint(x: center.x, y: (center.y - heightRadius))
            let left = CGPoint(x: (center.x - widthRadius), y: center.y)
            let right = CGPoint(x: (center.x + widthRadius), y: center.y)
            var path = Path()
            path.move(to: top)
            path.addLine(to: left)
            path.addLine(to: bot)
            path.addLine(to: right)
            path.addLine(to: top)
            path.addLine(to: left)
            return path
        }
    }
    
}





//MARK: - Canvas Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SoloSetGameView(game: SoloSetGameViewModel(theme: StandardCardTheme()))
    }
}
