//
//  LayerListSheetView.swift
//  iOSSea
//
//  Created by nano on 14/04/2025.
//

import SwiftUI

struct LayerListSheetView: View {
    @StateObject var viewModel : PainterViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.layers, id: \.name) { layer in
                Button(action: {
                    viewModel.setActiveLayer(layer: layer)
                }, label: {
                    Text(layer.name)
                })
            }
        }
        Button(action: {
            viewModel.makeLayer(size: viewModel.size)
        }, label: {
            Text("Add new layer")
        })
    }
}
