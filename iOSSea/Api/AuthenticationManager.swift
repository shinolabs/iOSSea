//
//  AuthenticationManager.swift
//  iOSSea
//
//  Created by nano on 07/04/2025.
//

import Combine

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init() { }
    
    let eventSubject = PassthroughSubject<AuthenticationEvent, Never>()
    
    var state : AuthenticationState = AuthenticationState()
    
    func loggedIn() -> Bool {
        return state.token != nil
    }
    
    func getToken() -> String? {
        if state.token == nil {
            // TODO: Try to get from keychain
        }
        
        return state.token
    }
    
    func setToken(token: String) async {
        state.token = token
        eventSubject.send(.loggedIn)
        
        // Get our identity
        await setIdentity()
        
        // TODO: Set in keychain.
    }
    
    func setIdentity() async {
        do {
            let identity : GetIdentityResponse = try await PinkSeaClient.shared.query(GetIdentityRequest())
            state.did = identity.did
            
            print("Received our identity, it's \(identity.did)")
        } catch {
            // We've failed to fetch the identity, it means that it has expired.
            state.token = nil
        }
    }
}
