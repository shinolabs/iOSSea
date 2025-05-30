//
//  TimelineView.swift
//  iOSSea
//
//  Created by makrowave on 08/04/2025.
//

import SwiftUI

struct TimelineView<TReq: XrpcInvokable & OekakiRequestProtocol, VResp: Codable & OekakiResponseProtocol>: View {
    @EnvironmentObject var settings: SettingsManager
    @ObservedObject var viewModel = TimelineViewModel()
    @ObservedObject var queryWrapper: OekakiQueryWrapper<TReq>
    var refresh: UUID?
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
                            if(viewModel.posts.count == 0 && viewModel.hasInitialized) {
                                Text("Nothing here so far... (╥﹏╥)")
                            } else {
                                ProgressView()
                            }
                            
                        }.id("end")
                        .frame(minHeight: viewModel.posts.count == 0 ? geometry.size.height : 100)
                        .frame(maxWidth: .infinity)
                    }.scrollTargetLayout()
                }
                .refreshable {
                    loadData(true)
                }
                .scrollPosition(id: $viewModel.visibleItemID)
                .onChange(of: viewModel.visibleItemID) { old, new in
                    if(new == "end" && !viewModel.isLoading) {
                        loadData(false)
                    }
                }
            }
        }
        .onChange(of: refresh) {
            viewModel.posts = []
            loadData(true)
        }
        .background(Color.background)
        .onAppear {
            if(viewModel.posts.count == 0) {
                loadData(true)
            }
        }
    }
    
    func loadData(_ initialLoad: Bool) {
        Task {
            queryWrapper.setSince(nil)
            viewModel.isLoading = true
            if(initialLoad) {
                viewModel.hasInitialized = false
            }
            do {
                let timeline : VResp = try await PinkSeaClient.shared.query(queryWrapper.query)
                if(initialLoad) {
                    viewModel.posts = timeline.oekaki
                    viewModel.hasInitialized = true
                } else {
                    viewModel.posts += timeline.oekaki
                }
                viewModel.lastDate = viewModel.posts.last?.creationTime.replacingOccurrences(of: "+00:00", with: "Z")
            } catch let error as GenericClientError {
                print(error.message)
            }
            viewModel.isLoading = false
        }
    }
}
