//
//  SettingsView.swift
//  iOSSea
//
//  Created by makrowave on 08/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settings: SettingsManager
    var body: some View {
        VStack {
            List {
                HStack(spacing: 0) {
                    Text("")
                    Image(systemName: "sun.max.fill")
                        .padding(.trailing, 10)
                    SelectThemeView()
                }
                .listRowSeparatorTint(.text)
                .listRowBackground(Color.foreground)
                .foregroundStyle(.text, .text) //2nd style for chevron
                HStack(spacing: 0) {
                    Text("")
                    Image(systemName: "globe")
                        .padding(.trailing, 10)
                    SelectLanguageView()
                        
                }
                .listRowSeparatorTint(.text)
                .listRowBackground(Color.foreground)
                .foregroundStyle(.text, .text)
                HStack(spacing: 0) {
                    Text("")
                    Image(systemName: "eye.slash")
                        .padding(.trailing, 10).blur(radius: 1)
                    Toggle("Blur NSFW", isOn: $settings.blurNSFW)
                        
                }
                .listRowSeparatorTint(.text)
                .listRowBackground(Color.foreground)
                .foregroundStyle(.text, .text)
                HStack(spacing: 0) {
                    Text("")
                    Image(systemName: "eye.slash")
                        .padding(.trailing, 10)
                    Toggle("Hide NSFW", isOn: $settings.hideNSFW)
                        
                }
                .listRowSeparatorTint(.text)
                .listRowBackground(Color.foreground)
                .foregroundStyle(.text, .text)
                HStack(spacing: 0) {
                    Text("")
                    Image(systemName: "globe")
                        .padding(.trailing, 10)
                    SelectLanguageView()
                        
                }
                .listRowSeparatorTint(.text)
                .listRowBackground(Color.foreground)
                .foregroundStyle(.text, .text)
                
                
                
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
