//
//  Layer.swift
//  iOSSea
//
//  Created by nano on 14/04/2025.
//

import UIKit

class Layer : ObservableObject {
    @Published var name : String
    @Published var image : UIImage
    
    var size : CGSize
    var ctx : CGContext
    
    init(name: String, size: CGSize) {
        self.name = name
        self.size = size
        
        ctx = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!
        
        // Disable antialiasing
        ctx.setShouldAntialias(false)
        ctx.setAllowsAntialiasing(false)
        ctx.interpolationQuality = .none
        
        // Coordinates are flipped between UIKit and SwiftUI
        ctx.translateBy(x: 0, y: size.height)
        ctx.scaleBy(x: 1, y: -1)
        
        ctx.setFillColor(UIColor.clear.cgColor)
        ctx.fill(CGRect(origin: .zero, size: size))
        
        image = UIImage(cgImage: ctx.makeImage()!)
    }
    
    func fill(color: CGColor) {
        ctx.setFillColor(color)
        ctx.fill(CGRect(origin: .zero, size: size))
    }
    
    func rebuild() {
        image = UIImage(cgImage: ctx.makeImage()!)
    }
}
