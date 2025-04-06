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
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.posts, id: \.image) { post in
                        PostView(post: post).padding(.top, 0)
                    }
                }
                ProgressView()
            }
        }
        .onAppear {
            Task {
                do {
                    let timeline : GetRecentResponse = try await PinkSeaClient.shared.query(GetRecentRequest(since: nil, limit: nil))
                    
                    viewModel.posts = timeline.oekaki
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
