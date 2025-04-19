//
//  SearchView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

enum SearchType: String {
    case tags, profiles, posts
}


struct SearchView: View {
    private enum Selection {
        case posts
        case users
        case tags
    }
    @StateObject private var viewModel = TimelineViewModel()
    @State var searchText: String = ""
    @State var query: String = ""
    @State private var selection: Selection = .posts
    @State var refresh = UUID()
    var body: some View {
        VStack(spacing: 0) {
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
                    TimelineView<GetSearchResultsRequest, GetSearchResultsResponse>(
                        viewModel: viewModel,
                        queryWrapper: OekakiQueryWrapper<GetSearchResultsRequest>(
                            query: GetSearchResultsRequest(
                                type: SearchType.posts.rawValue,
                                query: query,
                                since: nil,
                                limit: nil)
                        ),
                        refresh: refresh
                    )
                case .users:
                    SearchResultScrollView(type: SearchType.profiles, query: query)
                case .tags:
                    SearchResultScrollView(type: SearchType.tags, query: query)
                }
            }
            
        }
        .searchable(text: $searchText)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .onSubmit(of: .search) {
            query = searchText
            refresh = UUID()
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
