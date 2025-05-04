//
//  PainterViewModel.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import UIKit

class PainterViewModel : ObservableObject {
    @Published var layers : [Layer] = []
    @Published var tool : Tool
    @Published var undoStack : UndoStack = UndoStack()
    
    @Published var lastPoint : CGPoint?
    @Published var toolSize : CGFloat = 8
    @Published var toolColor : CGColor = UIColor.black.cgColor
    @Published var size : CGSize = CGSize(width: 400, height: 400)
    
    @Published var scale : CGFloat = 1
    @Published var position : CGPoint = CGPointZero
    
    @Published var activeLayer : Layer? = nil

    init() {
        let color = CGColor(red: 0, green: 0, blue: 0, alpha: 255)
        
        tool = PenTool(size: 8, color: color)
        toolColor = color
        
        let layer = makeLayer(size: size)
        setActiveLayer(layer: layer)
        
        activeLayer!.fill(color: UIColor.white.cgColor)
        activeLayer!.rebuild()
    }
    init(from layers: [Layer]) {
        let color = CGColor(red: 0, green: 0, blue: 0, alpha: 255)
        
        tool = PenTool(size: 8, color: color)
        toolColor = color
        
        self.layers = layers
        let layer = layers.first(where: {layer in layer.active})
        setActiveLayer(layer: layer ?? layers.first!)
        activeLayer!.rebuild()
    }
    
    func makeLayer(size: CGSize) -> Layer {
        let layer = Layer(name: "Layer #\(layers.count + 1)", size: size)
        layers.append(layer)
        
        return layer
    }
    
    func setActiveLayer(layer: Layer) {
        print("Set active layer to: \(layer.name)")
        if let prevLayer = activeLayer {
            prevLayer.active = false
        }
        
        activeLayer = layer
        layer.active = true
    }
    
    func useTool(from: CGPoint, to: CGPoint) {
        guard let layer = activeLayer else {
            print("No active layer selected!")
            return
        }
        
        tool.draw(from: from, to: to, ctx: layer.ctx)
        layer.rebuild()
    }
    
    func updateTool() {
        tool.update(color: toolColor, size: toolSize)
    }
    
    func render() -> UIImage {
        // Create a new temporary layer to store the final pic
        let finalLayer = Layer(name: "Temporary", size: size)
        
        finalLayer.ctx.translateBy(x: 0, y: size.height)
        finalLayer.ctx.scaleBy(x: 1, y: -1)
        
        for layer in layers {
            guard let cgImage = layer.image.cgImage else {
                fatalError("Failed to render final image.")
            }
            
            finalLayer.ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: layer.size.width, height: layer.size.height))
        }
        
        // Rebuild the layer
        finalLayer.rebuild()
        
        return finalLayer.image
    }
}
