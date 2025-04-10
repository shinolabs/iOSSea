//
//  SettingsManager.swift
//  iOSSea
//
//  Created by makrowave on 09/04/2025.
//

import SwiftUI
import CoreData
class SettingsManager: ObservableObject {
    let context = PersistenceController.shared.container.viewContext
    
    @Published var theme: ColorScheme? {
        didSet {
            var theme: String?
            switch self.theme {
            case .light:
                theme = "light"
            case .dark:
                theme = "dark"
            default:
                theme = "auto"
            }
            saveOrUpdateSetting(key: "theme", value: theme)
        }
    }
    
    @Published var language: String? {
        didSet {
            saveOrUpdateSetting(key: "language", value: language)
        }
    }
    
    init() {
        let languageSetting = fetchSetting(key: "language")
        self.language = languageSetting?.value
        
        let themeSetting = fetchSetting(key: "theme")
        if let theme = themeSetting {
            switch theme.value {
            case "light":
                self.theme = .light
            case "dark":
                self.theme = .dark
            default:
                self.theme = nil
            }
        }
    }
    
    func fetchSetting(key: String) -> Setting? {
        let request: NSFetchRequest<Setting> = Setting.fetchRequest()
        request.predicate = NSPredicate(format: "key == %@", key)
        request.fetchLimit = 1  // Get only one result

        do {
            return try context.fetch(request).first
        } catch {
            print("Failed to fetch setting for key \(key): \(error)")
            return nil
        }
    }

    func saveOrUpdateSetting(key: String, value: String?) {
        let setting = fetchSetting(key: key) ?? Setting(context: context) // Fetch or create new
        setting.key = key
        setting.value = value

        do {
            try context.save()
            print("Setting saved/updated successfully!")
        } catch {
            print("Failed to save setting: \(error)")
        }
    }
}
