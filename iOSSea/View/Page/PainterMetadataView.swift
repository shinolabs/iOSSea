//
//  PainterMetadataView.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import SwiftUI

struct PainterMetadataView : View {
    @ObservedObject var viewModel : PainterMetadataViewModel
    @State var selectedPost : Post? = nil
    @State var isUploading : Bool = false
    
    var body: some View {
        ScrollView {
            if let image = viewModel.renderedImage {
                Image(uiImage: image)
            } else {
                Text("No image lol")
            }
            
            GroupBox(label: Label("Description", systemImage: "note.text.badge.plus")) {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Description",
                              text: $viewModel.description,
                              axis: .vertical)
                    Text("Attaching a short description helps give context about your drawing. Optional.")
                        .font(.footnote)
                }
            }
            .textFieldStyle(.roundedBorder)
            
            GroupBox(label: Label("Social", systemImage: "sharedwithyou.circle")) {
                VStack(alignment: .leading, spacing: 8) {
                    Toggle("NSFW", isOn: $viewModel.nsfw)
                    Text("Please check if your post contains adult content such as nudity or highly suggestive themes.")
                        .font(.footnote)
                    
                    Toggle("Crosspost to Bluesky", isOn: $viewModel.crosspostToBluesky)
                    Text("If checked, we'll automatically create a post for you on Bluesky with the image and a link to PinkSea attached.")
                        .font(.footnote)
                }
            }
            
            Button {
                Task { await postImage() }
            } label: {
                Label("Post", systemImage: "paperplane.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(isUploading ? Color.gray : Color.accentColor)
                    .foregroundColor(isUploading ? .gray : .white)
                    .cornerRadius(12)
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Posting your artwork")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
    }
    
    func postImage() async {
        isUploading = true
        defer {
            isUploading = false
        }
        
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
            
            await moveToPostView(resp: resp)
        } catch let error as XrpcError {
            let errorMessage = error.message ?? error.error
            print("Failed to post image! \(errorMessage)")
        } catch {
            print("Failed to post image due to an unknown error.")
        }
    }
    
    func moveToPostView(resp: PutOekakiResponse) async {
        do {
            let getOekakiResponse : GetOekakiResponse = try await PinkSeaClient.shared.query(GetOekakiRequest(did: AuthenticationManager.shared.getDid()!, rkey: resp.rkey))
            
            await MainActor.run {
                UploadEventManager.shared.sendUploadedEvent(getOekakiResponse.parent)
            }
            
            print("Moving!")
        } catch {
            print("Failed to move to post view.")
        }
    }
}

#Preview {
    PainterMetadataView(viewModel: PainterMetadataViewModel())
}
