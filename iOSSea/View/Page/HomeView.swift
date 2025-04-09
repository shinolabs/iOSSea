//
//  PostsView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject var viewModel = TimelineViewModel()
    @StateObject var queryWrapper = OekakiQueryWrapper<GetRecentRequest>(query: GetRecentRequest(since: nil, limit: nil))
    @State private var visibleItemID: String?
    @State private var last: String?
    @State private var isLoading: Bool = false
    var body: some View {
        TimelineView<GetRecentRequest, GetRecentResponse>(
            viewModel: viewModel,
            queryWrapper: queryWrapper
        )
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
