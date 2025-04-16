//
//  LayerItemView.swift
//  iOSSea
//
//  Created by nano on 15/04/2025.
//

import SwiftUI

struct PreviewData {
    let layer : Layer
    
    init() {
        let layer = Layer(name: "Test", size: CGSize(width: 200, height: 200))
        layer.fill(color: CGColor(red: 255, green: 0, blue: 0, alpha: 255))
        layer.rebuild()
        
        self.layer = layer
    }
}

struct LayerItemView: View {
    @StateObject var layer : Layer
    
    let onTap : () -> Void
    
    var body: some View {
        HStack {
            Image(uiImage: layer.image)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(.rect(cornerRadius: 15))
            VStack {
                Text(layer.name)
                    .fontWeight(layer.active ? .bold : .regular)
            }
            Spacer()
        }
        .padding()
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    LayerItemView(layer: PreviewData().layer, onTap: {})
}
