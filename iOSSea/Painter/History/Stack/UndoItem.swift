//
//  UndoItem.swift
//  iOSSea
//
//  Created by nano on 01/05/2025.
//

class UndoItem {
    let layer: Layer
    var parent: UndoItem? = nil
    var child: UndoItem? = nil
    
    init(layer: Layer) {
        self.layer = layer
    }
    
    func detachChildren() {
        guard child != nil else {
            // No children, we can safely return
            return
        }
        
        var lastChild: UndoItem? = self
        while let child = lastChild {
            lastChild = child.child
            child.child = nil
        }
    }
}
