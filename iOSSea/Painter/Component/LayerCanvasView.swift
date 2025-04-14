//
//  LayerCanvasView.swift
//  iOSSea
//
//  Created by nano on 14/04/2025.
//

import SwiftUI

struct LayerCanvasView: View {
    @StateObject var layer : Layer
    @Binding var scale : CGFloat
    
    var body: some View {
        Image(uiImage: layer.image)
            .resizable()
            .interpolation(.none)
            .aspectRatio(contentMode: .fit)
            .frame(width: layer.image.size.width * scale, height: layer.image.size.height * scale)
    }
}
