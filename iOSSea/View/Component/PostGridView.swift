//
//  PostGridView.swift
//  iOSSea
//
//  Created by makrowave on 07/04/2025.
//

import SwiftUI

struct PostGridView: View {
    let posts: [Post]
    let maxWidth: CGFloat
    @State var width: CGFloat = 0
    @EnvironmentObject var settings: SettingsManager
    
    
    public var body: some View {
        ScrollView {
            WrappingHStack {
                ForEach(posts, id: \.cid) { post in
                    if(!(post.nsfw && settings.hideNSFW)) {
                        NavigationLink(destination: {
                            PostPageView(post: post)
                        }) {
                            let gridWidth = width / (ceil(width/maxWidth))
                            MiniPostView(post: post)
                                .frame(
                                    width: gridWidth,
                                    height: gridWidth
                                )
                                .clipped(antialiased: true)
                        }
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
    PostGridView(posts: posts, maxWidth: 160)
}
