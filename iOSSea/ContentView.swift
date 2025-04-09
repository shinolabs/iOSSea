//
//  ContentView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    @StateObject private var viewModel : ContentViewModel = ContentViewModel()
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("", systemImage: "house", value: 0) {
                NavigationStack {
                    HomeView()
                        .navigationTitle("Home")
                        .toolbarVisibility(.visible)
                        .toolbarBackground(Color.psForeground, for: .automatic)
                        .toolbarBackground(.visible, for: .automatic)
                        .toolbar {
                            if viewModel.isLoggedIn {
                                NavigationLink(destination: PainterView()) {
                                    Image(systemName: "plus.square")
                                }
                            }
                        }
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.psForeground, for: .tabBar)
            }
            Tab("", systemImage: "magnifyingglass", value: 1) {
                NavigationStack{
                    SearchView()
                        .navigationTitle("Search")
                        .toolbarVisibility(.visible)
                        .toolbarBackground(Color.psForeground, for: .automatic)
                        .toolbarBackground(.visible, for: .automatic)
                        
                }
                .toolbarBackground(Color.psForeground, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
            Tab("", systemImage: "person.crop.circle.fill", value: 2) {
                NavigationStack{
                    Group {
                        if !viewModel.isLoggedIn {
                            LoginView()
                        } else {
                            ProfileView(did: AuthenticationManager.shared.getDid()!, ownProfile: true)
                        }
                    }
                    .navigationTitle(!viewModel.isLoggedIn ? "Log in" : "Profile")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbarVisibility(.visible)
                    .toolbarBackground(Color.psForeground, for: .automatic)
                    .toolbarBackground(.visible, for: .automatic)
                    .toolbar {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        }
                    }
                        
                }
                .toolbarBackground(Color.psForeground, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
        }
        .onReceive(AuthenticationManager.shared.eventSubject) { event in
            switch event {
            case .loggedIn:
                viewModel.isLoggedIn = true
            }
        }
    }
}

#Preview {
    ContentView()
}
