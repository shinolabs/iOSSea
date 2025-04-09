//
//  SelectThemeView.swift
//  iOSSea
//
//  Created by makrowave on 09/04/2025.
//

import SwiftUI

struct SelectThemeView: View {
    @ObservedObject private var settings = SettingsManager.shared
    let options: [(String, String, ColorScheme?)] = [
        ("circle.lefthalf.fill", "System", nil),
        ("sun.max.fill", "Light", .light),
        ("moon.fill", "Dark", .dark)
    ]

    var body: some View {
        Picker("Theme", selection: $settings.theme) {
            ForEach(options, id: \.1) { icon, title, scheme in
                HStack {
                    Image(systemName: icon).foregroundStyle(.text)
                    Text(title)
                }
                .tag(scheme as ColorScheme?)
            }
        }
        .pickerStyle(.menu)
        .tint(.text)
    }
}

#Preview {
    SelectThemeView()
}
