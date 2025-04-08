//
//  ProfileViewModel.swift
//  iOSSea
//
//  Created by makrowave on 07/04/2025.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile = Profile()
    @Published var posts: [Post] = []
    @Published var replies: [Post] = []
}
