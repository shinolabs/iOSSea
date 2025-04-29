//
//  PainterMetadataViewModel.swift
//  iOSSea
//
//  Created by nano on 28/04/2025.
//

import SwiftUI

class PainterMetadataViewModel : ObservableObject {
    @Published var renderedImage : UIImage?
    @Published var description: String = ""
    
    init() {
        renderedImage = nil
    }
    
    init(from: PainterViewModel) {
        renderedImage = from.render()
    }
    
    func toBase64Uri() -> String? {
        guard let image = renderedImage else {
            print("Failed to unwrap image!")
            return nil
        }
        
        guard let pngData = image.pngData() else {
            print("Could not create png data from image!")
            return nil
        }
        
        let base64Data = pngData.base64EncodedString(options: [])
        return "data:image/png;base64,\(base64Data)"
    }
}
