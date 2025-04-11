//
//  PenTool.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import UIKit
import CoreGraphics

class PenTool : Tool {
    private var brush : CGImage?
    
    init() {
        generateBrush(size: 16)
    }
    
    func generateBrush(size: Int) {
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
        
        let r = size / 2
        for x in 0..<size {
            for y in 0..<size {
                let dx = x - r
                let dy = y - r
                if (dx*dx + dy*dy <= r*r) {
                    let offset = y * bytesPerRow + x * bytesPerPixel
                    let buffer = bitmapData.bindMemory(to: UInt8.self, capacity: totalBytes)
                    
                    buffer[offset + 0] = 0   // R
                    buffer[offset + 1] = 0   // G
                    buffer[offset + 2] = 0   // B
                    buffer[offset + 3] = 255 // A
                }
            }
        }
        
        
        brush = context.makeImage()!
    }
    
    
    func draw(from: CGPoint, to: CGPoint, ctx: CGContext) {
        guard let brush = brush else { return }
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
}
