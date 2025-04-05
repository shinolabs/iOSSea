//
//  iOSSeaApp.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

@main
struct iOSSeaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
