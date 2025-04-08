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
            Text("Settings")
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
    }
}

#Preview {
    SettingsView()
}
