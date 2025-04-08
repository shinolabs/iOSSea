//
//  PostViewModel.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import SwiftUI

class TimelineViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var visibleItemID: String?
    @Published var lastDate: String?
    @Published var isLoading: Bool = false
}
