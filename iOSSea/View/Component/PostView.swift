//
//  Post.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import SwiftUI

struct PostView: View {
    let post: Post
    @State private var image: Image? = nil
    @State private var width: CGFloat = 0
    var body: some View {
        VStack(spacing: 0) {
            //Image
            AsyncImage(url: post.getUrl()) { phase in
                switch phase {
                case .empty:
                    VStack {
                        ProgressView()
                    }.frame(height: width)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    VStack {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .padding(60)
                            .foregroundColor(.gray)
                        Text(post.alt)
                    }
                    
                @unknown default:
                    EmptyView()
                }
            }
            VStack {
                //Profile
                HStack {
                    NavigationLink(destination: ProfileView(did: post.author.did)) {
                        Image("apple")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    VStack(alignment: .leading) {
                        NavigationLink(destination: ProfileView(did: post.author.did)) {
                            Text("@\(post.author.handle)")
                                .font(.title3.bold())
                        }
                        Text(post.getFormattedDate() ?? "")
                            .font(.subheadline)
                    }
                }
                .padding(.leading, 20)
                .padding(.top, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                //Tags
                WrappingHStack {
                    ForEach(post.tags, id: \.self) { tag in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor(named: "Foreground")!))
                            Text("#\(tag)")
                                .padding(5)
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .fixedSize()
                    }
                }
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            }.overlay(
                HStack(spacing: 0) {
                    Color(UIColor(named: "Foreground")!).frame(width: 8)
                    Spacer()
                }
            )
        }
        .overlay(
            ZStack {
                GeometryReader { geometry in
                    VStack {}.onAppear {
                        width = geometry.size.width
                    }.onChange(of: geometry.size.width) { old, new in
                        width = new
                    }
                    
                }
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Color(UIColor(named: "Foreground")!).frame(width: 3) // Left
                        Spacer()
                        Color(UIColor(named: "Foreground")!).frame(width: 3) // Right
                    }
                    Color(UIColor(named: "Foreground")!).frame(height: 3) // Bottom
                }
            }
            
        )
    }
}

#Preview {
    NavigationStack {
        PostView(post: Post(
            tags: ["hanyuu", "higurashi_no_naku_koro_ni"],
            creationTime: "2025-01-19T21:34:21.432307+00:00",
            author: Author(did: "did:plc:vrk3nc7pk3b5kuk6y5dewnuw", handle: "pref.ata.moe"),
            image: "https://harbor.pinksea.art/did:plc:vrk3nc7pk3b5kuk6y5dewnuw/bafkreih7ssj5c5nqvdqwmlvs774c6yilz67czbxcrnlyhht2slm7lb4rby",
            alt: "hanyuu in the windows xp wallpaper",
            nsfw: false,
            cid: "",
            at: "")
        )
    }
}
