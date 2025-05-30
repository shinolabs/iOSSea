//
//  CachedImageView.swift
//  iOSSea
//
//  Created by makrowave on 11/04/2025.
//
import SwiftUI
import CachedAsyncImage

struct CachedImageView: View {
    let url: String
    var alt: String?
    var loadingWidth: CGFloat = 0
    var loadingHeight: CGFloat = 0
    var body: some View {
        CachedAsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: loadingWidth, height: loadingHeight)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                VStack {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                        .foregroundColor(.gray)
                    if let alt = alt {
                        Text(alt)
                    }
                }
            @unknown default:
                EmptyView()
            }
        }
        .background(Color.background)
    }
}


