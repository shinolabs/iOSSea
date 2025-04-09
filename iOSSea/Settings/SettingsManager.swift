//
//  SettingsManager.swift
//  iOSSea
//
//  Created by makrowave on 09/04/2025.
//

import SwiftUI

class SettingsManager: ObservableObject {
    public static let shared = SettingsManager()
    
    @Published var theme: ColorScheme?
}
