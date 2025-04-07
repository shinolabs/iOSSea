//
//  ContentView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
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
                        LoginView()
                            .navigationTitle("Profile")
                            .toolbarVisibility(.visible)
                            .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
                            .toolbarBackground(.visible, for: .automatic)
                            
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
