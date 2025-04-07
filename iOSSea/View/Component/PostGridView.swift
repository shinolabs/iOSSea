//
//  PostGridView.swift
//  iOSSea
//
//  Created by makrowave on 07/04/2025.
//

import SwiftUI

struct PostGridView: View {
    let posts: [Post]
    @State var width: CGFloat = 0
    let maxWidth: CGFloat
    public var body: some View {
        ScrollView {
            WrappingHStack {
                ForEach(posts, id: \.cid) { post in
                    MiniPostView(post: post).frame(width: width / (ceil(width/maxWidth)))
                }
            }
        }.frame(width: .infinity)
        .overlay {
            GeometryReader {geometry in
                VStack {}.onChange(of: geometry.size.width) {old, new in
                    print(new)
                    width = new
                }
                .onAppear {
                    print(geometry.size.width)
                    width = geometry.size.width
                }
            }
        }
    }
}

#Preview {
    PostGridView(posts: posts, maxWidth: 160)
}
