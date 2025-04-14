//
//  PainterViewModel.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import UIKit

class PainterViewModel : ObservableObject {
    @Published var layers : [Layer] = []
    @Published var tool : Tool = PenTool(size: 8, color: CGColor(red: 0, green: 0, blue: 0, alpha: 255))
    @Published var lastPoint : CGPoint?
    @Published var toolSize : CGFloat = 8
    @Published var size : CGSize = CGSize(width: 400, height: 400)
    
    @Published var scale : CGFloat = 1
    @Published var position : CGPoint = CGPointZero
    
    @Published var activeLayer : Layer? = nil

    init() {
        makeLayer(size: size)
        setActiveLayer(layer: layers.first!)
        
        activeLayer!.fill(color: UIColor.white.cgColor)
    }
    
    func makeLayer(size: CGSize) {
        let layer = Layer(name: "Layer #\(layers.count + 1)", size: size)
        layers.append(layer)
    }
    
    func setActiveLayer(layer: Layer) {
        print("Set active layer to: \(layer.name)")
        activeLayer = layer
    }
    
    func useTool(from: CGPoint, to: CGPoint) {
        guard let layer = activeLayer else {
            print("No active layer selected!")
            return
        }
        
        tool.draw(from: from, to: to, ctx: layer.ctx)
        layer.rebuild()
    }
    
    func updateTool(color: CGColor) {
        tool.update(color: color, size: toolSize)
    }
}
