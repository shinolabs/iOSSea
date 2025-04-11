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
    
    init() {
        if let blurNSFWSetting = fetchSetting(key: "blurNSFW") {
            if(blurNSFWSetting.value == "true"){
                blurNSFW = true
            } else {
                blurNSFW = false
            }
        }
        if let hideNSFWSetting = fetchSetting(key: "hideNSFW") {
            if(hideNSFWSetting.value == "true"){
                hideNSFW = true
            } else {
                hideNSFW = false
            }
        }
        
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
    
    @Published var blurNSFW: Bool = true {
        didSet {
            saveOrUpdateSetting(key: "blurNSFW", value: blurNSFW ? "true" : "false")
        }
    }
    
    @Published var hideNSFW: Bool = false {
        didSet {
            saveOrUpdateSetting(key: "hideNSFW", value: hideNSFW ? "true" : "false")
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
