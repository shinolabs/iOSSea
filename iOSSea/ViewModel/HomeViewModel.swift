//
//  PostViewModel.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
}
