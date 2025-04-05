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
        VStack {
            ScrollView {
                Text("Home View")
            }
            Spacer()
        }

    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
