//
//  PostPageView.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import SwiftUI

struct PostPageView: View {
    let post: Post
    @State var comments: [Post] = []
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PostView(post: post)
                ForEach(Array(comments.enumerated()), id: \.element.cid) {index, comment in
                    CommentView(post: comment, last: index == comments.count - 1)
                    
                }
            }
        }
        .background(Color.background)
        .navigationTitle("@\(post.author.handle)'s post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color.foreground, for: .automatic)
        .onAppear {
            Task {
                do {
                    let post : GetOekakiResponse = try await PinkSeaClient.shared.query(GetOekakiRequest(did: post.author.did, rkey: post.at.components(separatedBy: "/").last ?? ""))
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
