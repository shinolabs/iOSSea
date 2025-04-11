//
//  PainterViewModel.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import UIKit

class PainterViewModel : ObservableObject {
    @Published var image : UIImage
    @Published var tool : Tool = PenTool()
    @Published var lastPoint : CGPoint?
    
    @Published var scale : CGFloat = 1
    @Published var position : CGPoint = CGPointZero
    
    private var ctx : CGContext
    
    init() {
        let size = CGSize(width: 400, height: 400)
        ctx = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!
        
        // Coordinates are flipped between UIKit and SwiftUI
        ctx.translateBy(x: 0, y: size.height)
        ctx.scaleBy(x: 1, y: -1)
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fill(CGRect(origin: .zero, size: size))
        image = UIImage(cgImage: ctx.makeImage()!)
    }
    
    func useTool(from: CGPoint, to: CGPoint) {
        tool.draw(from: from, to: to, ctx: ctx)
        image = UIImage(cgImage: ctx.makeImage()!)
    }
}
