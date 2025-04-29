//
//  PainterView.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import SwiftUI

struct PainterScreenView: View {
    @StateObject var viewModel : PainterViewModel = PainterViewModel()
    
    var body: some View {
        Painter(viewModel: viewModel)
            .navigationTitle("Editor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarVisibility(.visible, for: .automatic)
            .toolbarBackgroundVisibility(.visible, for: .automatic)
            .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
            .toolbar {
                NavigationLink(destination: PainterMetadataView(viewModel: PainterMetadataViewModel(from: viewModel))) {
                    Image(systemName: "checkmark.square")
                }
            }
    }
}


#Preview {
    PainterScreenView()
}
