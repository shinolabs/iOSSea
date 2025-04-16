//
//  ContentView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: SettingsManager
    @State private var selectedTab: Int = 0
    @StateObject private var viewModel : ContentViewModel = ContentViewModel()
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Recent", systemImage: "house", value: 0) {
                NavigationStack {
                    HomeView()
                        .navigationTitle("Recent")
                        .toolbarVisibility(.visible)
                        .toolbarBackground(Color.foreground, for: .automatic)
                        .toolbarBackground(.visible, for: .automatic)
                        .toolbar {
                            if viewModel.isLoggedIn {
                                NavigationLink(destination: PainterScreenView()) {
                                    Image(systemName: "plus.square")
                                }
                            }
                        }
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.foreground, for: .tabBar)
                .id("tab1\(settings.language ??  "")")
            }
            Tab("Search", systemImage: "magnifyingglass", value: 1) {
                NavigationStack{
                    SearchView()
                        .navigationTitle("Search")
                        .toolbarVisibility(.visible)
                        .toolbarBackground(Color.foreground, for: .automatic)
                        .toolbarBackground(.visible, for: .automatic)
                        
                }
                .toolbarBackground(Color.foreground, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .id("tab2\(settings.language ??  "")")
            }
            Tab("Profile", systemImage: "person.crop.circle.fill", value: 2) {
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
                    .toolbarBackground(Color.foreground, for: .automatic)
                    .toolbarBackground(.visible, for: .automatic)
                    .toolbar {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        }
                    }
                        
                }
                .toolbarBackground(Color.foreground, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .id("tab3\(settings.language ??  "")")
            }
        }
        .onReceive(AuthenticationManager.shared.eventSubject) { event in
            switch event {
            case .loggedIn:
                viewModel.isLoggedIn = true
            case .loggedOut:
                viewModel.isLoggedIn = false
            }
        }.preferredColorScheme(settings.theme)
            .tint(.tint)
            .environment(\.locale, Locale(identifier: settings.language ?? ""))
    }
}

#Preview {
    ContentView().environmentObject(SettingsManager())
}
