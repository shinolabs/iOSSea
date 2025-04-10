//
//  SelectLanguageView.swift
//  iOSSea
//
//  Created by makrowave on 09/04/2025.
//

import SwiftUI

struct SelectLanguageView: View {
    @ObservedObject private var settings = SettingsManager.shared
    let options = Bundle.main.localizations.sorted { $0 < $1 }

    var body: some View {
        Picker("Language", selection: $settings.language) {
            Text("Auto").tag(nil as String?)
            ForEach(options, id: \.self) { language in
                Text(getLocalizedLanguage(language: language)).tag(language)
            }
        }
        .pickerStyle(.menu)
        .tint(.text)
    }
    func getLocalizedLanguage(language: String) -> String {
        let locale = Locale(identifier: language)
        return locale.localizedString(forIdentifier: language)?.capitalized ?? language
    }
}

#Preview {
    SelectLanguageView()
}
