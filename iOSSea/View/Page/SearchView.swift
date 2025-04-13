//
//  SearchView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

struct SearchView: View {
    private enum Selection {
        case posts
        case users
        case tags
    }
    @StateObject private var viewModel = TimelineViewModel()
    @State var searchText: String = ""
    @State private var selection: Selection = .posts
    var body: some View {
        VStack(spacing: 0) {
            TextField("Search for posts, users, tags...", text: $searchText)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .font(.subheadline)
                .background(Color.gray.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
            Color.foreground.frame(height: 1)
            HStack {
                Spacer()
                Button(action: {selection = .posts}) {
                    Text("Posts").bold(selection == .posts)
                }
                Spacer()
                Button(action: {selection = .users}) {
                    Text("Users").bold(selection == .users)
                }
                Spacer()
                Button(action: {selection = .tags}) {
                    Text("Tags").bold(selection == .tags)
                }
                Spacer()
            }.padding(.vertical, 10)
            Color.foreground.frame(height: 1)
            VStack {
                switch selection {
                case .posts:
                    TimelineView<GetRecentRequest, GetRecentResponse>(
                        viewModel: viewModel,
                      queryWrapper: OekakiQueryWrapper<GetRecentRequest>(query: GetRecentRequest(since: nil, limit: nil)))
                case .users:
                    ScrollView {
                        SearchResultView(
                            url: "https://harbor.pinksea.art/did:plc:dglney4ocjv73dxxkfel6q3z/bafkreih5s6rxidbo6cw7zdi42ofmey2m4h4wseppmqipx2qcz5klq3stem",
                            title: "Makrowave",
                            subtitle: "@makrowave.bsky.social",
                            destination: {ProfileView(did: "did:plc:dglney4ocjv73dxxkfel6q3z")}
                        )
                        SearchResultView(
                            url: "https://harbor.pinksea.art/did:plc:dglney4ocjv73dxxkfel6q3z/bafkreih5s6rxidbo6cw7zdi42ofmey2m4h4wseppmqipx2qcz5klq3stem",
                            title: "Makrowave",
                            subtitle: "@makrowave.bsky.social",
                            destination: {ProfileView(did: "did:plc:dglney4ocjv73dxxkfel6q3z")}
                        )
                        SearchResultView(
                            url: "https://harbor.pinksea.art/did:plc:dglney4ocjv73dxxkfel6q3z/bafkreih5s6rxidbo6cw7zdi42ofmey2m4h4wseppmqipx2qcz5klq3stem",
                            title: "Makrowave",
                            subtitle: "@makrowave.bsky.social",
                            destination: {ProfileView(did: "did:plc:dglney4ocjv73dxxkfel6q3z")}
                        )

                    }
                case .tags:
                    ScrollView {
                        SearchResultView(url: "https://harbor.pinksea.art/did:plc:dglney4ocjv73dxxkfel6q3z/bafkreih5s6rxidbo6cw7zdi42ofmey2m4h4wseppmqipx2qcz5klq3stem",
                                         title: "#pc",
                                         subtitle: "1 post", destination: {EmptyView()})
                        SearchResultView(url: "https://harbor.pinksea.art/did:plc:dglney4ocjv73dxxkfel6q3z/bafkreih5s6rxidbo6cw7zdi42ofmey2m4h4wseppmqipx2qcz5klq3stem",
                                         title: "#pc",
                                         subtitle: "1 post", destination: {EmptyView()})
                        SearchResultView(url: "https://harbor.pinksea.art/did:plc:dglney4ocjv73dxxkfel6q3z/bafkreih5s6rxidbo6cw7zdi42ofmey2m4h4wseppmqipx2qcz5klq3stem",
                                         title: "#pc",
                                         subtitle: "1 post", destination: {EmptyView()})
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity)
        .background(Color.background)

    }
}

#Preview {
    NavigationStack{
        SearchView()
    }
}
