//
//  AuthenticationState.swift
//  iOSSea
//
//  Created by nano on 07/04/2025.
//

import SwiftUI

class AuthenticationState : ObservableObject {
    @Published var token : String?
    @Published var did : String?
}
