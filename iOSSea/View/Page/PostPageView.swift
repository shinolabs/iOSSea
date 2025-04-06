//
//  PostPageView.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import SwiftUI

struct PostPageView: View {
    let post: Post
    let comments: [Post]
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PostView(post: post)
                ForEach(Array(comments.enumerated()), id: \.element.cid) {index, comment in
                    CommentView(post: comment, last: index == comments.count - 1)
                    
                }
            }
        }
        .navigationTitle("@\(post.author.handle)'s post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
    }
}

#Preview {
    NavigationStack {
        PostPageView(post: posts[1], comments: comments)
    }
}
