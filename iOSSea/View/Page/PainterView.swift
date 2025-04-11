//
//  PainterView.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import SwiftUI

struct PainterView: View {
    @StateObject var viewModel = PainterViewModel()
    @State var imageRect : CGRect = .zero
    
    var body: some View {
        ZStack {
            ZStack {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .interpolation(.none)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: viewModel.image.size.width * viewModel.scale, height: viewModel.image.size.height * viewModel.scale)
            }.frame(width: viewModel.image.size.width * viewModel.scale, height: viewModel.image.size.height * viewModel.scale)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                imageRect = geo.frame(in: .global)
                            }
                            .onChange(of: geo.size) { _, _ in
                                imageRect = geo.frame(in: .global)
                            }
                    }
                )
            
            
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { value in
                    var point = value.location
                    point.x = (point.x - imageRect.minX - viewModel.position.x) / viewModel.scale
                    point.y = (point.y - imageRect.minY - viewModel.position.y) / viewModel.scale
                    viewModel.useTool(from: viewModel.lastPoint ?? point, to: point)
                    viewModel.lastPoint = point
                }
                .onEnded { _ in
                    viewModel.lastPoint = nil
                }
        )
        .simultaneousGesture(
            MagnificationGesture()
                .onChanged { value in
                    viewModel.scale = value
                }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Painter"))
        .navigationTitle("Editor")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
        .toolbar {
            NavigationLink(destination: PainterMetadataView()) {
                Image(systemName: "checkmark.square")
            }
        }
    }
}


#Preview {
    PainterView()
}
