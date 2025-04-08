//
//  MiniPostView.swift
//  iOSSea
//
//  Created by makrowave on 07/04/2025.
//

import SwiftUI

struct MiniPostView: View {
    let post: Post
    let width: CGFloat
    let reply: Bool
    var body: some View {
        AsyncImage(url: post.getUrl()) { phase in
            switch phase {
            case .empty:
                VStack {
                    ProgressView()
                        .scaledToFill()
                }
                .frame(width: width, height: reply ? width/3 : width)
                
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text(post.alt)
                }
                
            @unknown default:
                EmptyView()
            }
        }
    }
}
