//
//  LoginView.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel : LoginViewModel = LoginViewModel()
    @State var loggingIn : Bool = false
    @State var didError : Bool = false
    @State var errorMessage : String = ""
    var body: some View {
        VStack {
            Text("Login to start creating!")
                .bold()
            TextField("@handle.bsky.social", text: $viewModel.handle)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            SecureField("Password (optional)", text: $viewModel.password)
            Button(action: {
                Task {
                    loggingIn = true
                    
                    do {
                        let response : BeginLoginFlowResponse = try await PinkSeaClient.shared.procedure(
                            BeginLoginFlowRequest(handle: viewModel.handle, password: viewModel.password, redirectUrl: "pinksea://callback")
                        )
                        
                        print("Redirecting to \(response.redirect)")
                    } catch let error as XrpcError {
                        loggingIn = false
                        didError = true
                        errorMessage = error.message ?? error.error
                        print("Failed to log in! \(errorMessage)")
                    }
                }
            }, label: {
                if viewModel.password.isEmpty {
                    Text("Log in via OAuth")
                } else {
                    Text("Log in via app passwords")
                }
            })
            .buttonStyle(.bordered)
            .disabled(loggingIn)
            .alert("Failed to log in", isPresented: $didError) {
                Button(role: .cancel) {
                    didError = false
                } label: {
                    Text("Ok")
                }
            } message: {
                Text(errorMessage)
            }
        }
        .padding()
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    LoginView()
}
