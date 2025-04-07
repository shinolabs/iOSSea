//
//  PostGridView.swift
//  iOSSea
//
//  Created by makrowave on 07/04/2025.
//

import SwiftUI

struct PostGridView: View {
    @State var width: CGFloat = 0
    
    let posts: [Post]
    let maxWidth: CGFloat
    let reply: Bool
    
    public var body: some View {
        ScrollView {
            WrappingHStack {
                ForEach(posts, id: \.cid) { post in
                    NavigationLink(destination: {
                        if(reply) {
                            PostFromReplyView(rkey: post.at.components(separatedBy: "/").last ?? "", did: post.author.did)
                            
                        } else {
                            PostPageView(post: post)
                        }
                    }) {
                        MiniPostView(post: post).frame(width: width / (ceil(width/maxWidth)))
                    }
                }
            }
        }
        .overlay {
            GeometryReader {geometry in
                VStack {}.onChange(of: geometry.size.width) {old, new in
                    width = new
                }
                .onAppear {
                    width = geometry.size.width
                }
            }
        }
    }
}

#Preview {
    PostGridView(posts: posts, maxWidth: 160, reply: false)
}
