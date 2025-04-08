//
//  ContentView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    @StateObject private var sharedAuthStateObject = AuthenticationManager.shared.state
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                Tab("", systemImage: "house", value: 0) {
                    NavigationStack {
                        HomeView()
                            .navigationTitle("Home")
                            .toolbarVisibility(.visible)
                            .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
                            .toolbarBackground(.visible, for: .automatic)
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .tabBar)
                }
                Tab("", systemImage: "magnifyingglass", value: 1) {
                    NavigationStack{
                        SearchView()
                            .navigationTitle("Search")
                            .toolbarVisibility(.visible)
                            .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
                            .toolbarBackground(.visible, for: .automatic)
                            
                    }
                    .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                }
                Tab("", systemImage: "person.crop.circle.fill", value: 2) {
                    NavigationStack{
                        let notLoggedIn = sharedAuthStateObject.token == nil || sharedAuthStateObject.did == nil
                        Group {
                            if notLoggedIn {
                                LoginView()
                                    
                            } else {
                                ProfileView(did: sharedAuthStateObject.did!, ownProfile: true)
                            }
                        }
                        .navigationTitle(notLoggedIn ? "Log in" : "Profile")
                        .navigationBarTitleDisplayMode(.large)
                        .toolbarVisibility(.visible)
                        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
                        .toolbarBackground(.visible, for: .automatic)
                        .toolbar {
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gear")
                            }
                        }
                            
                    }
                    .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
