//
//  Draft.swift
//  iOSSea
//
//  Created by makrowave on 04/05/2025.
//

import Foundation
import SwiftUI
import CoreData

class Draft: Identifiable {
    var id: NSManagedObjectID?
    var image: UIImage
    var date: Date
    
    init(image: UIImage) {
        self.image = image
        date = Date()
    }
    
    init(from: SavedDraft) {
        id = from.objectID
        image = UIImage(data: from.image!)!
        date = from.lastChange!
    }
    
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
