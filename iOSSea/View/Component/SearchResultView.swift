//
//  SearchResultView.swift
//  iOSSea
//
//  Created by makrowave on 13/04/2025.
//

import SwiftUI

struct SearchResultView<Destination: View>: View {
    @EnvironmentObject var settings: SettingsManager
    let url: String
    let title: String
    let subtitle: String
    let nsfw: Bool
    let destination: () -> Destination
    
    init(
            url: String,
            title: String,
            subtitle: String,
            nsfw: Bool = false,
            @ViewBuilder destination: @escaping () -> Destination
        ) {
            self.url = url
            self.title = title
            self.subtitle = subtitle
            self.destination = destination
            self.nsfw = nsfw
        }
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 0) {
                HStack {
                    CachedImageView(url: url)
                        .blurOverlay(nsfw && (settings.blurNSFW || settings.hideNSFW))
                        .frame(width: 80, height: 80)
                        .cornerRadius(22)
                        .padding(.leading)
                    VStack(alignment: .leading) {
                        Text(title).font(.title2).bold()
                        Text(subtitle).fontWeight(.thin)
                    }
                    Spacer()
                }.padding(.vertical, 10)
                Color.foreground
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    SearchResultView(url: "https://harbor.pinksea.art/did:plc:dglney4ocjv73dxxkfel6q3z/bafkreih5s6rxidbo6cw7zdi42ofmey2m4h4wseppmqipx2qcz5klq3stem",
                     title: "#pc",
                     subtitle: "1 post", destination: {EmptyView()})
}
 

struct TagSearchView: View {
    @EnvironmentObject var settings: SettingsManager
    let tag: TagResponse
    
    var body: some View {
        SearchResultView(url: tag.oekaki.image,
                         title: "#\(tag.tag)",
                         subtitle: "\(tag.count) post\(tag.count == 1 ? "" : "s")",
                         nsfw: tag.oekaki.nsfw) {
            TimelineView<GetTagFeedRequest, GetTagFeedResponse>(
                queryWrapper: OekakiQueryWrapper<GetTagFeedRequest>(
                    query: GetTagFeedRequest(
                        tag: tag.tag,
                        since: nil,
                        limit: nil)
                )
            )
            .background(Color.background)
            .navigationTitle("#\(tag.tag)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarVisibility(.visible, for: .automatic)
            .toolbarBackgroundVisibility(.visible, for: .automatic)
            .toolbarBackground(Color.foreground, for: .automatic)
        }
    }
}

struct ProfileSearchView: View {
    let did: String
    @State var profile: Profile?
    var body: some View {
        SearchResultView(url: profile?.avatarUrl ?? "",
                         title: profile?.nickname ?? "",
                         subtitle: profile != nil ? "@\(profile!.nickname)" : "",
                         nsfw: false) {
            ProfileView(did: did)
        }
        .onAppear {
            Task {
                do {
                    let resp : GetProfileResponse = try await PinkSeaClient.shared.query(GetProfileRequest(did: did))
                    profile = Profile(from: resp)
                } catch let error as GenericClientError {
                    print(error.message)
                }
            }
        }
    }
}
