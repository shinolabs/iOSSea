//
//  iOSSeaApp.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

@main
struct iOSSeaApp: App {
    init() {
        let memoryCapacity = 100 * 1024 * 1024 //100MB
        let diskCapacity = 100 * 1024 * 1024 //100MB
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myCache")
        URLCache.shared = urlCache
    }
    let settingsManager = SettingsManager()
    let draftViewModel = DraftViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settingsManager)
                .environmentObject(draftViewModel)
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
