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
            List {
                ForEach(viewModel.layers, id: \.name) { layer in
                    LayerItemView(layer: layer, onTap: {
                        viewModel.setActiveLayer(layer: layer)
                    })
                }.onDelete { offsets in
                    viewModel.layers.remove(atOffsets: offsets)
                }
            }
        }
        Button(action: {
            let layer = viewModel.makeLayer(size: viewModel.size)
            viewModel.setActiveLayer(layer: layer)
        }, label: {
            Text("Add new layer")
        })
    }
}
