//
//  ContentView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabEnum = .home
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                Tab(value: .home) {
                    HomeView()
                        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                } label: {
                    Image(systemName: "house").symbolVariant(.none)
                }
                Tab("", systemImage: "magnifyingglass", value: .profile) {
                    SearchView()
                        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                }
                Tab("", systemImage: "person.crop.circle.fill", value: .settings) {
                    SettingsView()
                        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                }
            }
            .navigationTitle(selectedTab.title)
            .toolbarVisibility(.visible)
            .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
            .toolbarBackground(.visible, for: .automatic)
        }
    }
}

#Preview {
    ContentView()
}
