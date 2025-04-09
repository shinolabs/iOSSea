//
//  PainterView.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import SwiftUI

struct PainterView: View {
    @StateObject var viewModel : PainterViewModel = PainterViewModel()
    var body: some View {
        ZStack {
            Image(uiImage: viewModel.image)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            viewModel.useTool(from: viewModel.lastPoint ?? value.location, to: value.location)
                            viewModel.lastPoint = value.location
                        }
                        .onEnded { _ in
                            viewModel.lastPoint = nil
                        }
                )
                .border(.accent)
        }.scaledToFill().background(Color.black)
    }
}

#Preview {
    PainterView()
}
