//
//  TabItem.swift
//  iOSSea
//
//  Created by makrowave on 06/04/2025.
//

import Foundation

enum TabEnum: Identifiable {
    case home, profile, settings
    var id: Self { self }
    var title: String {
        switch self {
            case .home:
            return "Recent"
        case .profile:
            return "Search"
        case .settings:
            return "Profile"
        }
    }
}
