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
    @State var lastZoom : CGFloat = 1.0
    @State var color : CGColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    
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
            
            HStack {
                Button(action: {
                    viewModel.tool = PenTool(size: 8, color: color)
                }, label: {
                    Image(systemName: "pencil")
                        .foregroundStyle(.white)
                })
                
                ColorPicker("", selection: $color, supportsOpacity: false)
                    .frame(width: 10)
                    .onChange(of: color) { _ in
                        viewModel.updateTool(color: color)
                    }
            }
            .padding()
            .background(.black)
            .border(.accent)
            .position(x: 50, y: 50)
            
        }
        .simultaneousGesture(
            MagnificationGesture()
                .onChanged { value in
                    let dv = value - lastZoom
                    viewModel.scale += dv
                    if (viewModel.scale < 0.5) {
                        viewModel.scale = 0.5
                    }
                    lastZoom = value
                }
                .onEnded { _ in
                    viewModel.lastPoint = nil
                    lastZoom = 1.0
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
