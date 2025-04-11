//
//  ProfileReplyView.swift
//  iOSSea
//
//  Created by makrowave on 11/04/2025.
//

import SwiftUI

struct ProfileReplyView: View {
    let post: Post
    @State var width: CGFloat = 0
    @State var originalPost: Post?
    @State var avatarUrl = ""
    var body: some View {
        VStack() {
            VStack {
                HStack {
                    Text("In response to a post by")
                        .font(.caption)
                        .padding(.leading)
                    if(originalPost != nil) {
                        NavigationLink(destination: ProfileView(did: originalPost!.author.did)) {
                            Group {
                                if !avatarUrl.isEmpty {
                                    AsyncImage(url: URL(string: avatarUrl)) { result in
                                        result.image?
                                            .resizable()
                                            .scaledToFill()
                                    }
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        NavigationLink(destination: ProfileView(did: originalPost!.author.did)) {
                            Text("@\(originalPost!.author.handle)")
                                .font(.caption.bold())
                        }
                    }
                    Spacer()
                }.frame(minHeight: 30)
                    .padding(.top, 5)
                NavigationLink(destination: PostFromReplyView(rkey: post.at.components(separatedBy: "/").last ?? "", did: post.author.did)){
                    AsyncImage(url: post.getUrl()) { phase in
                        switch phase {
                        case .empty:
                            VStack {
                                ProgressView()
                            }.frame(height: width/3)
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
                }
            }
            .background(Color.background)
            .padding(.top, 1)
            .padding(.bottom, 1)
            .padding(.trailing, 1)
            .padding(.leading, 5)
        }.background(Color.foreground)
        .onAppear {
            Task {
                do {
                    let rkey = post.at.components(separatedBy: "/").last ?? ""
                    let did = post.author.did
                    let parent : GetParentForReplyResponse = try await PinkSeaClient.shared.query(GetParentForReplyRequest(did: did, rkey: rkey))
                    let post : GetOekakiResponse = try await PinkSeaClient.shared.query(GetOekakiRequest(did: parent.did, rkey: parent.rkey))
                    self.originalPost = post.parent
                } catch let error as GenericClientError {
                    print(error.message)
                }
            }
        }
        .overlay {
            GeometryReader { geometry in
                VStack {}.onChange(of: geometry.size.width) {old, new in
                    width = new
                }.onAppear {
                    width = geometry.size.width
                }
            }
        }
        .onAppear {
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

#Preview {
    NavigationStack {
        ProfileReplyView(post: comments[2])
    }
}
