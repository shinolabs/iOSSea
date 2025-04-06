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
                
            }
        }
        .onAppear {
            //For testing
            viewModel.posts = posts
        }

    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
