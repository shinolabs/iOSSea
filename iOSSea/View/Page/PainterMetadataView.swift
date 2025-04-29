//
//  PainterMetadataView.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import SwiftUI

struct PainterMetadataView : View {
    @StateObject var viewModel : PainterMetadataViewModel
    var body : some View {
        VStack {
            if (viewModel.renderedImage != nil) {
                Text("Rendered image")
                Image(uiImage: viewModel.renderedImage!)
            } else {
                Text("No image lol")
            }
            TextField(text: $viewModel.description) {
                Text("Description")
            }
            Button(action: {
                postImage()
            }, label: {
                Text("Post")
            })
        }
    }
    
    func postImage() {
        print(viewModel.toBase64Uri() ?? "Failed to get base64 data")
    }
}

#Preview {
    PainterMetadataView(viewModel: PainterMetadataViewModel())
}
