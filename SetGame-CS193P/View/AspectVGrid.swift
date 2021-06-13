//
//  AspectVGrid.swift
//  MemoryGame-CS193P
//
//  Created by Matthew Folbigg on 04/06/2021.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    var minColumns: Int
    var minItemWidth: CGFloat
    
    init(items: [Item], aspectRatio: CGFloat, minItemWidth: CGFloat, minColumns: Int, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        self.minColumns = minColumns
        self.minItemWidth = minItemWidth
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
            VStack {
                let suggestedItemWidth = itemWidthToFit(itemCount: items.count, in: geometry.size, aspectRatio: aspectRatio)
                let width: CGFloat = suggestedItemWidth > minItemWidth ? suggestedItemWidth : minItemWidth
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                            .padding(6)
                    }
                }
                Spacer(minLength: 0)
            }
            
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func itemWidthToFit(itemCount: Int, in size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        // This function is not my own. It was provided in the CS193P lecture and all crdit goes to the CS193P team.
        // I have modified its name and added the minimum column count
        var columnCount = 1
        var rowCount = items.count
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / aspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        //MARK: - Minimum Column Count
        if columnCount < minColumns {
            columnCount = minColumns
        }
        return floor(size.width / CGFloat(columnCount))
    }
    
    
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
