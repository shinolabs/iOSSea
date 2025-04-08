//
//  PostsView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .init()
    @State private var visibleItemID: String?
    @State private var last: String?
    @State private var isLoading: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.posts, id: \.image) { post in
                            NavigationLink(destination: PostPageView(post: post)) {
                                PostView(post: post).id(post.cid)
                            }
                        }
                        VStack {
                            ProgressView()
                        }.id("end")
                        .frame(minHeight: viewModel.posts.count == 0 ? geometry.size.height : 500)
                        .frame(maxWidth: .infinity)
                    }.scrollTargetLayout()
                }
                .scrollPosition(id: $visibleItemID)
                .onChange(of: visibleItemID) { old, new in
                    if(new == "end" && !isLoading) {
                        isLoading = true
                        Task {
                            do {
                                let timeline : GetRecentResponse = try await PinkSeaClient.shared.query(GetRecentRequest(since: last, limit: nil))
                                viewModel.posts += timeline.oekaki
                                last = viewModel.posts.last?.creationTime.replacingOccurrences(of: "+00:00", with: "Z")
                            } catch let error as GenericClientError {
                                print(error.message)
                            }
                            isLoading = false
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                do {
                    let timeline : GetRecentResponse = try await PinkSeaClient.shared.query(GetRecentRequest(since: nil, limit: nil))
                    
                    viewModel.posts = timeline.oekaki
                    last = viewModel.posts.last?.creationTime.replacingOccurrences(of: "+00:00", with: "Z")
                } catch let error as GenericClientError {
                    print(error.message)
                }
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
