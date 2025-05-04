//
//  DraftsPage.swift
//  iOSSea
//
//  Created by makrowave on 04/05/2025.
//

import SwiftUI

struct DraftsPage: View {
    @EnvironmentObject var viewModel: DraftViewModel
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.drafts, id: \.id) {draft in
                    NavigationLink(destination: PainterScreenView(draft: draft, layers: viewModel.getLayers(for: draft))) {
                        HStack {
                            Text("")
                            Image(uiImage: draft.image)
                                .resizable()
                                .frame(maxWidth: 80, maxHeight: 80)
                            Spacer()
                            Text(draft.dateAsString())
                        }
                    }
                }.onDelete(perform: viewModel.delete)
            }
        }
        .navigationTitle("Drafts")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.visible, for: .automatic)
        .toolbarBackgroundVisibility(.visible, for: .automatic)
        .toolbarBackground(Color(UIColor(named: "Foreground")!), for: .automatic)
        .toolbar {
            NavigationLink(destination: PainterScreenView()) {
                Image(systemName: "plus.square")
            }
        }
    }
}

#Preview {
    NavigationStack {
        DraftsPage()
    }.environmentObject(DraftViewModel())
}
