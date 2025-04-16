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
        
        var x0 = Int(from.x)
        var y0 = Int(from.y)
        let x1 = Int(to.x)
        let y1 = Int(to.y)
        
        let dx = abs(x1 - x0)
        let sx = x0 < x1 ? 1 : -1
        let dy = -abs(y1 - y0)
        let sy = y0 < y1 ? 1 : -1
        
        var error = dx + dy
        
        let halfSize = brush.width / 2
        
        while true {
            ctx.draw(brush, in: CGRect(x: x0 - halfSize, y: y0 - halfSize, width: brush.width, height: brush.height))
            
            if x0 == x1, y0 == y1 {
                break
            }
            
            let e2 = 2 * error
            if e2 >= dy {
                error += dy
                x0 += sx
            }
            if e2 <= dx {
                error += dx
                y0 += sy
            }
        }
    }
    
    func update(color: CGColor, size: CGFloat) {
        allocBrush(sizeFloat: size, color: color)
    }
}
