//
//  ViewExtensions.swift
//  iOSSea
//
//  Created by makrowave on 11/04/2025.
//

import SwiftUI

public extension View {
    func blurButtonOverlay(active: Bool, disabled: Bool = false , value: CGFloat = 10, action: @escaping () -> Void) -> some View {
        return self
            .clipped(antialiased: true)
            .blur(radius: active ? value : 0)
            .overlay {
                if(active) {
                    VStack {
                        Button(action: action) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.background)
                                    .frame(width: 80, height: 30)
                                    .blur(radius: 4)
                                Text("NSFW")
                                    .foregroundStyle(.accent)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        }.disabled(disabled)
                    }
                }
            }
    }
    
    func blurOverlay(_ active: Bool, value: CGFloat = 10) -> some View {
        return self
            .clipped(antialiased: true)
            .blur(radius: active ? value : 0)
            .overlay {
                if(active) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.background)
                            .frame(width: 80, height: 30)
                            .blur(radius: 4)
                        Text("NSFW")
                            .foregroundStyle(.accent)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
    }
    
}
