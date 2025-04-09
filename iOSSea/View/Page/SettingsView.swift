//
//  SettingsView.swift
//  iOSSea
//
//  Created by makrowave on 08/04/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            List {
                HStack(spacing: 0) {
                    SelectThemeView()
                }
                .listRowSeparatorTint(.text)
                .listRowBackground(Color.foreground)
                .foregroundStyle(.text, .text) //2nd style for chevron
                
            }
            .scrollContentBackground(.hidden)
            .background(Color.background)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color.foreground, for: .automatic)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
