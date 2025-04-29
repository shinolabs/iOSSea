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
        ScrollView {
            if (viewModel.renderedImage != nil) {
                Image(uiImage: viewModel.renderedImage!)
            } else {
                Text("No image lol")
            }
            
            GroupBox(label: Label("Description", systemImage: "note.text.badge.plus")) {
                TextField(text: $viewModel.description, axis: .vertical) {
                    Text("Description")
                        .padding()
                }
                Text("Attaching a short description helps give context about your drawing. Optional.")
                    .font(.footnote)
                
            }.textFieldStyle(.roundedBorder)
                .padding()
            
            GroupBox(label: Label("Social", systemImage: "sharedwithyou.circle")) {
                Toggle(isOn: $viewModel.nsfw) {
                    Text("NSFW")
                }
                Text("Please check if your post contains adult content such as nudity or highly suggestive themes.")
                    .font(.footnote)
                
                Toggle(isOn: $viewModel.crosspostToBluesky) {
                    Text("Crosspost to Bluesky")
                }
                Text("If checked, we'll automatically create a post for you on Bluesky with the image and a link to PinkSea attached.")
                    .font(.footnote)
            }.padding()
            
            Button(action: {
                Task {
                    await postImage()
                }
            }, label: {
                Text("Post")
            }).buttonStyle(.borderedProminent)
        }
    }
    
    func postImage() async {
        guard let uri = viewModel.toBase64Uri() else {
            print("Failed to encode image.")
            return
        }
        
        var request = PutOekakiRequest(data: uri)
        request.alt = viewModel.description
        request.bskyCrosspost = viewModel.crosspostToBluesky
        request.nsfw = viewModel.nsfw
        
        do {
            let resp : PutOekakiResponse = try await PinkSeaClient.shared.procedure(request)
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
