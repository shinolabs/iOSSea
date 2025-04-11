//
//  MiniPostView.swift
//  iOSSea
//
//  Created by makrowave on 07/04/2025.
//

import SwiftUI
struct MiniPostView: View {
    let post: Post
    var body: some View {
        CachedImageView(url: post.image, alt: post.alt)
            .scaledToFill()
    }
}
