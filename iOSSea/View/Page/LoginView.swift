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
    @State var oauthNeedLogin : Bool = false
    @State var oauthPage : URL = URL(string: "https://google.com")!
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
                        
                        if !response.redirect.starts(with: "pinksea") {
                            oauthNeedLogin = true
                            oauthPage = URL(string: response.redirect)!
                        } else {
                            let code = response.redirect.split(separator: "code=")
                                .last!
                            Task {
                                await AuthenticationManager.shared.setToken(token: String(code))
                            }
                            
                        }
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
            .sheet(isPresented: $oauthNeedLogin) {
                SafariView(url: $oauthPage)
            }
            .onReceive(AuthenticationManager.shared.eventSubject) { event in
                switch event {
                case .loggedIn:
                    oauthNeedLogin = false
                }
            }
        }
        .padding()
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    LoginView()
}
