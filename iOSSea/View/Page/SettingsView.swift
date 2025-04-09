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
                .listRowSeparatorTint(Color.psText)
                .listRowBackground(Color.psForeground)
                .foregroundStyle(Color.psText, Color.psText) //2nd style for chevron
                
            }
            .scrollContentBackground(.hidden)
            .background(Color.psBackground)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.psBackground)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color.psForeground, for: .automatic)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
