//
//  ToolSettingsSheetView.swift
//  iOSSea
//
//  Created by nano on 14/04/2025.
//

import SwiftUI

struct ToolSettingsSheetView: View {
    @StateObject var viewModel : PainterViewModel
    var body: some View {
        VStack {
            Slider(value: $viewModel.toolSize, in: 1...64, step: 1) { value in
                viewModel.updateTool()
            }
        }
    }
}
