//
//  SafariView.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import SwiftUI
import SafariServices

struct SafariView : UIViewControllerRepresentable {
    @Binding var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
