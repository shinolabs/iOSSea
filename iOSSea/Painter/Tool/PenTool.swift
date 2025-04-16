//
//  PenTool.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import UIKit
import CoreGraphics

class PenTool : AbstractBrushTool {
    override func generateBrush(size: Int, color: CGColor, pixmap: UnsafeMutablePointer<UInt8>) {
        let bytesPerPixel = 4
        let bytesPerRow = size * bytesPerPixel
        let components = color.components!
        
        let r = size / 2
        for x in 0..<size {
            for y in 0..<size {
                let dx = x - r
                let dy = y - r
                
                if (dx*dx + dy*dy <= r*r) {
                    let offset = y * bytesPerRow + x * bytesPerPixel
                    
                    pixmap[offset + 0] = UInt8(components[0] * 255)
                    pixmap[offset + 1] = UInt8(components[1] * 255)
                    pixmap[offset + 2] = UInt8(components[2] * 255)
                    pixmap[offset + 3] = 255
                }
            }
        }
    }
}
