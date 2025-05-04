//
//  DraftViewModel.swift
//  iOSSea
//
//  Created by makrowave on 04/05/2025.
//

import Foundation
import SwiftUI

class DraftViewModel : ObservableObject {
    //Change to use core data
    @Published var drafts: [Draft] = [
        Draft(image: UIImage(named: "apple")!, date: Date(timeIntervalSinceNow: -3000)),
        Draft(image: UIImage(named: "apple")!, date: Date(timeIntervalSinceNow: -1000)),
        Draft(image: UIImage(named: "apple")!, date: Date()),
        Draft(image: UIImage(named: "apple")!, date: Date(timeIntervalSinceNow: -4000)),
    ]
    
    func delete(at offsets: IndexSet) -> Void {
        drafts.remove(atOffsets: offsets)
    }
}
