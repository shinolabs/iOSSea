//
//  LoginViewModel.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import SwiftUI

class LoginViewModel : ObservableObject {
    @Published var handle: String = ""
    @Published var password: String = ""
}
