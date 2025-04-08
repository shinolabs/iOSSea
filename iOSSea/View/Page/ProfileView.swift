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
    var body: some View {
        VStack(spacing: 0) {
            //Profile
            HStack {
                //Profile picture - not implemented yet
                VStack {
                    Image("apple")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 20)
                //Info
                VStack(alignment: .leading) {
                    //Name and edit buttons - not implemented yet
                    HStack {
                        Text("Profile name").bold()
                    }
                    //Handle
                    Text("@\(viewModel.author.handle)")
                        .font(.subheadline).fontWeight(.light)
                    //Desc
                    Text("Description")
                        .font(.callout)
                    //Sites
                    HStack {
                        HStack {
                            Image(systemName: "link")
                            Text("[Bluesky](\("https://bsky.app/profile/\(viewModel.author.did)"))")
                        }
                        HStack {
                            Image(systemName: "link")
                            Text("[Website](\("https://\(viewModel.author.handle)"))")
                        }
                    }
                }
                Spacer()
            }.padding(.top, 10)
            Color(UIColor(named: "Foreground")!).frame(height: 1).padding(.vertical, 10)
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
            Color(UIColor(named: "Foreground")!).frame(height: 1).padding(.top, 10)
            PostGridView(
                posts: selection == .replies ? viewModel.replies : viewModel.posts,
                maxWidth: selection == .replies ? 500 : 160,
                reply: selection == .replies
            )
            Spacer()
        }
        .onAppear {
            Task {
                viewModel.author.did = did
                do {
                    let handle : GetHandleFromDidResponse = try await PinkSeaClient.shared.query(GetHandleFromDidRequest(did: did))
                    viewModel.author.handle = handle.handle
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
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(ownProfile ? .large : .inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
    }
}

#Preview {
    NavigationStack{
        ProfileView(did: "did:plc:vrk3nc7pk3b5kuk6y5dewnuw", ownProfile: true)
    }
}

