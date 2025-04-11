//
//  CommentView.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import SwiftUI
struct CommentView: View {
    let post: Post
    let last: Bool
    @EnvironmentObject var settings: SettingsManager
    @State private var height: CGFloat = 0
    @State private var width: CGFloat = 0
    @State private var avatarUrl: String = ""
    @State private var hidden: Bool = true
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            //Timeline
            ZStack(alignment: .trailing) {
                VStack(spacing: 0) {
                    Color.foreground.frame(width: 3)
                        .frame(height: height/2)
                    if(!last){
                        Color.foreground.frame(width: 3)
                            .frame(height: height/2)
                    } else {
                        Spacer()
                    }
                }.frame(width: 30)
                Color.foreground
                    .frame(width: 16.5, height: 3, alignment: .trailing)
                
            }
            .frame(width: 30, height: height)
            .fixedSize()
            
            //Body
            VStack(alignment: .leading, spacing: 0) {
                //Info
                HStack() {
                    NavigationLink(destination: ProfileView(did: post.author.did)) {
                        CachedImageView(url: avatarUrl)
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.leading, 7)
                    }
                    NavigationLink(destination: ProfileView(did: post.author.did)) {
                        Text("@\(post.author.handle)")
                            .bold()
                            .font(.system(size: 11, weight: .bold, design: .default))
                    }
                    Spacer()
                    Text(post.getFormattedDate() ?? "")
                        .font(.system(size: 11, weight: .medium, design: .default))
                        .padding(.trailing, 10)
                }
                .overlay(
                    ZStack {
                        GeometryReader { geometry in
                            VStack {}.onChange(of: geometry.size.width) {old, new in
                                width = new
                            }.onAppear {
                                width = geometry.size.width
                            }
                        }
                    }
                )
                .padding(.vertical, 5)
                .background(Color.background)
                .frame(alignment: .leading)
                //Image
                CachedImageView(url: post.image, alt: post.alt, loadingWidth: width, loadingHeight: width/3)
                    .blurButtonOverlay(active: post.nsfw && hidden && settings.blurNSFW,
                                       action: {hidden = false})
            }
            .padding(.leading, 7)
            .background(Color.foreground)
            .overlay(
                ZStack {
                    GeometryReader { geometry in
                        VStack {}.onChange(of: geometry.size.height) {old, new in
                            height = new
                        }.onAppear {
                            height = geometry.size.height
                        }
                    }
                }
            ).onAppear {
                Task {
                    do {
                        let resp : GetProfileResponse = try await PinkSeaClient.shared.query(GetProfileRequest(did: post.author.did))
                        avatarUrl = Profile(from: resp).avatarUrl
                    } catch let error as GenericClientError {
                        print(error.message)
                    }
                }
            }
        }
    }
}

#Preview {
    CommentView(post: comments[1], last: true)
        .environmentObject(SettingsManager())
}
