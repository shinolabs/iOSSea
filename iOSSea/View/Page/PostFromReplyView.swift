//
//  PostPageView.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import SwiftUI

struct PostFromReplyView: View {
    let rkey: String
    let did: String
    @State var post: Post?
    @State var comments: [Post] = []
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if(post == nil) {
                    
                } else {
                    PostView(post: post!)
                    ForEach(Array(comments.enumerated()), id: \.element.cid) {index, comment in
                        CommentView(post: comment, last: index == comments.count - 1)
                        
                    }
                }
            }
        }
        .background(Color.psBackground)
        .navigationTitle(post == nil ? "" : "@\(post!.author.handle)'s post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color.psForeground, for: .automatic)
        .onAppear {
            Task {
                do {
                    let parent : GetParentForReplyResponse = try await PinkSeaClient.shared.query(GetParentForReplyRequest(did: did, rkey: rkey))
                    let post : GetOekakiResponse = try await PinkSeaClient.shared.query(GetOekakiRequest(did: parent.did, rkey: parent.rkey))
                    self.post = post.parent
                    comments = post.children
                } catch let error as GenericClientError {
                    print(error.message)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PostPageView(post: posts[4])
    }
}
