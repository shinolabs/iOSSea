//
//  MiniPostView.swift
//  iOSSea
//
//  Created by makrowave on 07/04/2025.
//

import SwiftUI
struct MiniPostView: View {
    let post: Post
    @EnvironmentObject var settings: SettingsManager
    
    var body: some View {
        CachedImageView(url: post.image, alt: post.alt)
            .scaledToFill()
            .blur(radius: post.nsfw && settings.blurNSFW ? 13 : 0)
            .clipped(antialiased: true)
    }
}
