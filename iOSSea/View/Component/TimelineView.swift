//
//  TimelineView.swift
//  iOSSea
//
//  Created by makrowave on 08/04/2025.
//

import SwiftUI

struct TimelineView<T: XrpcInvokable & OekakiRequestProtocol, V: Codable & OekakiResponseProtocol>: View {
    @EnvironmentObject var settings: SettingsManager
    @ObservedObject var viewModel: TimelineViewModel
    @ObservedObject var queryWrapper: OekakiQueryWrapper<T>
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.posts, id: \.image) { post in
                            if(!(post.nsfw && settings.hideNSFW)) {
                                NavigationLink(destination: PostPageView(post: post)) {
                                    PostView(post: post, revealable: false).id(post.cid)
                                }
                            }
                        }
                        VStack {
                            ProgressView()
                        }.id("end")
                        .frame(minHeight: viewModel.posts.count == 0 ? geometry.size.height : 500)
                        .frame(maxWidth: .infinity)
                    }.scrollTargetLayout()
                }
                .refreshable {
                    doInitialDataLoad()
                }
                .scrollPosition(id: $viewModel.visibleItemID)
                .onChange(of: viewModel.visibleItemID) { old, new in
                    if(new == "end" && !viewModel.isLoading) {
                        viewModel.isLoading = true
                        Task {
                            do {
                                queryWrapper.setSince(viewModel.lastDate)
                                let timeline : V = try await PinkSeaClient.shared.query(queryWrapper.query)
                                viewModel.posts += timeline.oekaki
                                viewModel.lastDate = viewModel.posts.last?.creationTime.replacingOccurrences(of: "+00:00", with: "Z")
                            } catch let error as GenericClientError {
                                print(error.message)
                            }
                            viewModel.isLoading = false
                        }
                    }
                }
            }
        }
        .background(Color.background)
        .onAppear {
            if(viewModel.posts.count == 0) {
                doInitialDataLoad()
            }
        }
    }
    
    func doInitialDataLoad() {
        Task {
            queryWrapper.setSince(nil)
            viewModel.isLoading = true
            do {
                let timeline : V = try await PinkSeaClient.shared.query(queryWrapper.query)
                
                viewModel.posts = timeline.oekaki
                viewModel.lastDate = viewModel.posts.last?.creationTime.replacingOccurrences(of: "+00:00", with: "Z")
            } catch let error as GenericClientError {
                print(error.message)
            }
            viewModel.isLoading = false
        }
    }
}
