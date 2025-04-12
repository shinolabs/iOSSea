//
//  Button.swift
//  iOSSea
//
//  Created by makrowave on 12/04/2025.
//

import SwiftUI

struct ListButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(configuration.isPressed ? Color.gray.opacity(0.2) : Color.foreground)
    }
}
