//
//  PenTool.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import UIKit

struct PenTool : Tool {
    func draw(from: CGPoint, to: CGPoint, ctx: CGContext) {
        ctx.move(to: from)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.setLineWidth(2)
        ctx.setLineCap(.round)
        ctx.move(to: from)
        ctx.addLine(to: to)
        ctx.strokePath()
    }
}
