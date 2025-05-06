//
//  PainterView.swift
//  iOSSea
//
//  Created by nano on 09/04/2025.
//

import SwiftUI

struct PainterScreenView: View {
    var draft: Draft
    @StateObject var viewModel: PainterViewModel
    @EnvironmentObject var draftViewModel: DraftViewModel
    
    init(draft: Draft? = nil, layers: [Layer]? = nil) {
            let tempViewModel: PainterViewModel
            if let layers = layers {
                tempViewModel = PainterViewModel(from: layers)
            } else {
                tempViewModel = PainterViewModel()
            }

            _viewModel = StateObject(wrappedValue: tempViewModel)
            self.draft = draft ?? Draft(image: tempViewModel.render())
        }
    
    var body: some View {
        Painter(viewModel: viewModel)
            .navigationTitle("Editor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarVisibility(.visible, for: .automatic)
            .toolbarBackgroundVisibility(.visible, for: .automatic)
            .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
            .toolbar {
                HStack {
                    Button(action: {
                        draft.image = viewModel.render()
                        draftViewModel.saveDraft(
                            draft: draft,
                            layers: viewModel.layers
                        )
                    }) {
                        Image(systemName: "square.and.arrow.down.fill")
                    }
                    NavigationLink(destination: PainterMetadataView(viewModel: PainterMetadataViewModel(from: viewModel))) {
                        Image(systemName: "checkmark.square")
                    }
                }
            }
    }
}


//#Preview {
//    PainterScreenView()
//}
