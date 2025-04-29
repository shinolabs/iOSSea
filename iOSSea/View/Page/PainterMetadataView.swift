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
                Task {
                    await postImage()
                }
            }, label: {
                Text("Post")
            })
        }
    }
    
    func postImage() async {
        guard let uri = viewModel.toBase64Uri() else {
            print("Failed to encode image.")
            return
        }
        
        var request = PutOekakiRequest(data: uri)
        request.alt = viewModel.description
        
        do {
            var resp : PutOekakiResponse = try await PinkSeaClient.shared.procedure(request)
            print(resp.uri)
        } catch let error as XrpcError {
            let errorMessage = error.message ?? error.error
            print("Failed to post image! \(errorMessage)")
        } catch {
            print("Failed to post image due to an unknown error.")
        }
    }
}

#Preview {
    PainterMetadataView(viewModel: PainterMetadataViewModel())
}
