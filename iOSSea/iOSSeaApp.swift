//
//  iOSSeaApp.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

@main
struct iOSSeaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SettingsManager())
                .onOpenURL { url in
                    guard let host = url.host() else {
                        return
                    }
                    
                    if host == "callback" {
                        let code = url.query()!.replacing("code=", with: "")
                        Task {
                            await AuthenticationManager.shared.setToken(token: code)
                            print("Logged in with token \(code)")
                        }
                    }
                }
        }
    }
}
