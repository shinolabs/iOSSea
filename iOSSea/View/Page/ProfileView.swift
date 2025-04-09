//
//  SettingsView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

struct ProfileView: View {
    enum Selection {
        case posts, replies
    }
    
    let did: String
    @StateObject var viewModel = ProfileViewModel()
    @State var selection: Selection = .posts
    var ownProfile: Bool = false
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(spacing: 0) {
            //Profile
            HStack {
                //Profile picture - not implemented yet
                VStack {
                    Group {
                        if !viewModel.profile.avatarUrl.isEmpty {
                            AsyncImage(url: URL(string: viewModel.profile.avatarUrl)) { result in
                                result.image?
                                    .resizable()
                                    .scaledToFill()
                            }
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 20)
                //Info
                VStack(alignment: .leading) {
                    //Name and edit buttons - not implemented yet
                    HStack {
                        Text("\(viewModel.profile.nickname)").bold()
                    }
                    //Handle
                    Text("@\(viewModel.profile.handle)")
                        .font(.subheadline).fontWeight(.light)
                    //Desc
                    Text("\(viewModel.profile.description)")
                        .font(.callout)
                    //Sites
                    HStack {
                        ForEach(viewModel.profile.links, id: \.name) { link in
                            HStack {
                                Image(systemName: "link")
                                Button(action: {
                                    openURL(URL(string: link.url)!)
                                }, label: {
                                    Text(link.name)
                                })
                            }
                        }
                    }
                }
                Spacer()
            }.padding(.top, 10)
            Color.psForeground.frame(height: 1).padding(.vertical, 10)
            HStack {
                Spacer()
                Button(action: {selection = .posts}) {
                    Text("Posts").bold(selection == .posts)
                }
                Spacer()
                Spacer()
                Button(action: {selection = .replies}) {
                    Text("Replies").bold(selection == .replies)
                }
                Spacer()
            }
            Color.psForeground.frame(height: 1).padding(.top, 10)
            PostGridView(
                posts: selection == .replies ? viewModel.replies : viewModel.posts,
                maxWidth: selection == .replies ? 500 : 160,
                reply: selection == .replies
            )
            Spacer()
        }
        .onAppear {
            Task {
                do {
                    let resp : GetProfileResponse = try await PinkSeaClient.shared.query(GetProfileRequest(did: did))
                    viewModel.profile = Profile(from: resp)
                } catch let error as GenericClientError {
                    print(error.message)
                }
                
                do {
                    let feed : GetAuthorFeedResponse = try await PinkSeaClient.shared.query(GetAuthorFeedRequest(did: did))
                    
                    viewModel.posts = feed.oekaki
                } catch let error as GenericClientError {
                    print(error.message)
                }
                
                do {
                    let reponses : GetAuthorFeedResponse = try await PinkSeaClient.shared.query(GetAuthorRepliesRequest(did: did))
                    
                    viewModel.replies = reponses.oekaki
                } catch let error as GenericClientError {
                    print(error.message)
                }
            }
        }
        .background(Color.psBackground)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(ownProfile ? .large : .inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color.psForeground, for: .automatic)
    }
}

#Preview {
    NavigationStack{
        ProfileView(did: "did:plc:vrk3nc7pk3b5kuk6y5dewnuw", ownProfile: true)
    }
}

