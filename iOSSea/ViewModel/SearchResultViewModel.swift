//
//  SearchResultViewModel.swift
//  iOSSea
//
//  Created by makrowave on 18/04/2025.
//

import Foundation

class SearchResultViewModel: ObservableObject {
    @Published var profiles: [Author]?
    @Published var tags: [TagResponse]?
}
