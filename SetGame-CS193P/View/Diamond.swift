//
//  Diamond.swift
//  SetGame-CS193P
//
//  Created by Matthew Folbigg on 12/06/2021.
//

import SwiftUI

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
