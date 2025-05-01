//
//  ChangeRect.swift
//  iOSSea
//
//  Created by nano on 01/05/2025.
//

import UIKit

class ChangeRect {
    var from: CGPoint? = nil
    var to: CGPoint? = nil
    
    func expand(_ point: CGPoint) {
        var topLeft = from ?? point
        if topLeft.x > point.x {
            topLeft.x = point.x
        }
        
        if (topLeft.y > point.y) {
            topLeft.y = point.y
        }
        
        from = topLeft
        
        var bottomRight = to ?? point
        if bottomRight.x < point.x {
            bottomRight.x = point.x
        }
        
        if (bottomRight.y < point.y) {
            bottomRight.y = point.y
        }
        
        to = bottomRight
    }
    
    func toRect() -> CGRect {
        guard let topLeft = from,
              let bottomRight = to else {
            return .zero
        }
        
        let width = bottomRight.x - topLeft.x
        let height = bottomRight.y - topLeft.y
        
        return CGRect(
            x: topLeft.x,
            y: topLeft.y,
            width: width,
            height: height)
    }
}
