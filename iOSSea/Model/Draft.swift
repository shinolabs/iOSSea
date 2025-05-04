//
//  Draft.swift
//  iOSSea
//
//  Created by makrowave on 04/05/2025.
//

import Foundation
import SwiftUI

struct Draft: Identifiable {
    var id = UUID()
    var image: UIImage
    var date: Date
    
    func dateAsString() -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
        
        return dateFormatter.string(from: date)
    }
}
