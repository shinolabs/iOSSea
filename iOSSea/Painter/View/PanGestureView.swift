//
//  PanGestureView.swift
//  iOSSea
//
//  Created by nano on 16/04/2025.
//

import SwiftUI
import UIKit

struct PanGestureView : UIViewRepresentable {
    var onPan : (UIPanGestureRecognizer) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onPan: onPan)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let panRecognizer = UIPanGestureRecognizer(target: context.coordinator,
                                                   action: #selector(Coordinator.handlePan(_:)))
        view.addGestureRecognizer(panRecognizer)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator : NSObject {
        var onPan: (UIPanGestureRecognizer) -> Void
        
        init(onPan: @escaping (UIPanGestureRecognizer) -> Void) {
            self.onPan = onPan
        }
        
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            onPan(gesture)
        }
    }
}
