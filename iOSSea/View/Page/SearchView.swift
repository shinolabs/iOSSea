//
//  SearchView.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("Search View")
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.psBackground)

    }
}

#Preview {
    NavigationStack{
        SearchView()
    }
}
