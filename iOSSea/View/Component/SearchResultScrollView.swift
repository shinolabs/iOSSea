//
//  SearchResultScrollView.swift
//  iOSSea
//
//  Created by makrowave on 18/04/2025.
//

import SwiftUI

struct SearchResultScrollView: View {
    @StateObject var viewModel = SearchResultViewModel()
    let type: SearchType
    let query: String
    var body: some View {
        Group {
            if(query == "") {
                VStack {
                    Spacer()
                    Text("Search for something")
                    Spacer()
                }
            } else if(viewModel.tags == nil || viewModel.profiles == nil) {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else if(viewModel.tags!.isEmpty && viewModel.profiles!.isEmpty) {
                VStack {
                    Spacer()
                    Text("Nothing here so far... (╥﹏╥)")
                    Spacer()
                }
            } else {
                if(type == SearchType.profiles) {
                    ScrollView {
                        ForEach(viewModel.profiles!, id: \.did) { author in
                            ProfileSearchView(did: author.did)
                        }
                    }
                } else {
                    ScrollView {
                        ForEach(viewModel.tags!, id: \.tag) {tag in
                            TagSearchView(tag: tag)
                        }
                    }
                }
            }
        }
        .onAppear {
            if(query != "") {
                doDataLoad()
            }
        }
        .onChange(of: type) {
            doDataLoad()
        }.onChange(of: query) {
            doDataLoad()
        }
    }
    
    func doDataLoad() {
        Task {
            viewModel.tags = nil
            viewModel.profiles = nil
            do {
                let resp : GetSearchResultsResponse = try await PinkSeaClient.shared.query(GetSearchResultsRequest(type: type.rawValue, query: query))
                viewModel.tags = resp.tags
                viewModel.profiles = resp.profiles
            } catch let error as GenericClientError {
                print(error.message)
            }
        }
    }
}

#Preview {
//    SearchResultScrollView(type: .tags, query: "")
}
