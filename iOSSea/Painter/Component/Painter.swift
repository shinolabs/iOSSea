//
//  PainterView.swift
//  iOSSea
//
//  Created by nano on 14/04/2025.
//

import SwiftUI

struct Painter: View {
    @StateObject var viewModel : PainterViewModel
    @State var imageRect : CGRect = .zero
    @State var lastZoom : CGFloat? = nil
    @State var lastPosition : CGPoint? = nil
    @State var layerSheetVisible : Bool = false
    @State var toolSettingsSheetVisible : Bool = false
    @State var position : CGPoint = .zero
    
    var body: some View {
        ZStack {
            ZStack {
                ForEach(viewModel.layers, id: \.name) { layer in
                    LayerCanvasView(layer: layer, scale: $viewModel.scale)
                }
                
                PanGestureView { gesture in
                    let point = gesture.translation(in: gesture.view)
                    var dp = point
                    dp.x -= (lastPosition ?? point).x
                    dp.y -= (lastPosition ?? point).y
                    
                    position.x += dp.x
                    position.y += dp.y
                    
                    if (gesture.state == .ended) {
                        lastPosition = nil
                    } else {
                        lastPosition = point
                    }
                    
                }
            }
            .frame(width: viewModel.size.width * viewModel.scale, height: viewModel.size.height * viewModel.scale)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                // Defer this to run on the main queue
                                DispatchQueue.main.async {
                                    imageRect = geo.frame(in: .global)
                                }
                            }
                            .onChange(of: geo.size) { _, _ in
                                imageRect = geo.frame(in: .global)
                            }
                    }
                )
                .gesture(
                    DragGesture(minimumDistance: 0.01, coordinateSpace: .global)
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
                .offset(x: position.x, y: position.y)
            
            HStack {
                Button(action: {
                    viewModel.tool = PenTool(size: 8, color: viewModel.toolColor)
                }, label: {
                    Image(systemName: "pencil")
                        .foregroundStyle(.white)
                })
                
                Button(action: {
                    layerSheetVisible = true
                }, label: {
                    Image(systemName: "square.2.layers.3d.top.filled")
                        .foregroundStyle(.white)
                })
                
                Button(action: {
                    toolSettingsSheetVisible = true
                }, label: {
                    Image(systemName: "pencil.and.scribble")
                        .foregroundStyle(.white)
                })
                
                ColorPicker("", selection: $viewModel.toolColor, supportsOpacity: false)
                    .frame(width: 10)
                    .onChange(of: viewModel.toolColor) { _ in
                        viewModel.updateTool()
                    }
            }
            .padding()
            .background(.black)
            .border(.accent)
            .position(x: 50, y: 50)
            
        }
        .simultaneousGesture(
            MagnifyGesture(minimumScaleDelta: 0.01)
                .onChanged { gesture in
                    let dv = gesture.magnification - (lastZoom ?? gesture.magnification)
                    viewModel.scale += dv
                    if (viewModel.scale < 0.5) {
                        viewModel.scale = 0.5
                    }
                    lastZoom = gesture.magnification
                }
                .onEnded { gesture in
                    viewModel.lastPoint = nil
                    lastZoom = nil
                }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Painter"))
        .sheet(isPresented: $layerSheetVisible) {
            VStack {
                LayerListSheetView(viewModel: viewModel)
                Button(action: {
                    layerSheetVisible = false
                }, label: {
                    Text("Close")
                })
            }
            .presentationDetents([.medium])
        }
        .sheet(isPresented: $toolSettingsSheetVisible) {
            VStack {
                ToolSettingsSheetView(viewModel: viewModel)
                Button(action: {
                    toolSettingsSheetVisible = false
                }, label: {
                    Text("Close")
                })
            }
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    let viewModel = PainterViewModel()
    Painter(viewModel: viewModel)
}
