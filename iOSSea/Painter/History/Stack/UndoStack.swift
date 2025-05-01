//
//  UndoStack.swift
//  iOSSea
//
//  Created by nano on 01/05/2025.
//

class UndoStack {
    var head: UndoItem? = nil
    
    func pushChange() {
        guard let head = head else {
            return
        }
        
        head.detachChildren()
        
    }
    
    func undo() {
        guard let head = head, head.parent != nil else {
            return
        }
        
        self.head = head.parent
    }
    
    func redo() {
        guard let head = head, head.child != nil else {
            return
        }
        
        self.head = head.child
    }
}
