//
//  AbstractBrushTool.swift
//  iOSSea
//
//  Created by nano on 16/04/2025.
//

import UIKit

class AbstractBrushTool : Tool {
    private var brush : CGImage?
    
    init(size: CGFloat, color: CGColor) {
        allocBrush(sizeFloat: size, color: color)
    }
    
    func generateBrush(size: Int, color: CGColor, pixmap: UnsafeMutablePointer<UInt8>) {
        preconditionFailure("Tried to invoke generateBrush on an abstract brush tool.")
    }
    
    func allocBrush(sizeFloat: CGFloat, color: CGColor) {
        let size = Int(sizeFloat)
        guard size > 0 else {
            fatalError("Invalid brush size")
        }
        
        print("New brush size: \(size)")
        let bitsPerComponent = 8
        let bytesPerPixel = 4
        let bytesPerRow = size * bytesPerPixel
        let totalBytes = bytesPerRow * size
        
        let bitmapData = UnsafeMutableRawPointer.allocate(byteCount: totalBytes, alignment: MemoryLayout<UInt8>.alignment)
        memset(bitmapData, 0, size * size * bytesPerPixel)
        
        defer {
            bitmapData.deallocate()
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: bitmapData,
                                      width: size,
                                      height: size,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            fatalError("Could not create CGContext")
        }
        
        context.setShouldAntialias(false)
        context.setAllowsAntialiasing(false)
        context.interpolationQuality = .none
        
        let buffer = bitmapData.bindMemory(to: UInt8.self, capacity: totalBytes)
        generateBrush(size: size, color: color, pixmap: buffer)
        
        brush = context.makeImage()!
    }
    
    func draw(from: CGPoint, to: CGPoint, ctx: CGContext) {
        guard let brush = brush else {
            return
        }
        
        let dx = to.x - from.x
        let dy = to.y - from.y
        let distance = hypot(dx, dy)
        let steps = Int(distance)
            
        for i in 0...steps {
            let t = CGFloat(i) / CGFloat(steps)
            let x = (from.x + t * dx) - (CGFloat(brush.width) / 2.0)
            let y = (from.y + t * dy) - (CGFloat(brush.height) / 2.0)
            ctx.draw(brush, in: CGRect(x: x, y: y, width: CGFloat(brush.width), height: CGFloat(brush.height)))
        }
    }
    
    func update(color: CGColor, size: CGFloat) {
        allocBrush(sizeFloat: size, color: color)
    }
}
