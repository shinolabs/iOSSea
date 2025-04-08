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
    
    private var token : String? = nil
    private var did : String? = nil
    
    let eventSubject = PassthroughSubject<AuthenticationEvent, Never>()
    
    func loggedIn() -> Bool {
        return token != nil
    }
    
    func getDid() -> String? {
        return did
    }
    
    func getToken() -> String? {
        if token == nil {
            // TODO: Try to get from keychain
        }
        
        return token
    }
    
    func setToken(token: String) async {
        self.token = token
        
        // Get our identity
        await setIdentity()
        
        // We might have failed while fetching identity, make sure we don't do that.
        if self.token != nil {
            await MainActor.run {
                eventSubject.send(.loggedIn)
            }
        }
        
        // TODO: Set in keychain.
    }
    
    func setIdentity() async {
        do {
            let identity : GetIdentityResponse = try await PinkSeaClient.shared.query(GetIdentityRequest())
            self.did = identity.did
            
            print("Received our identity, it's \(identity.did)")
        } catch {
            // We've failed to fetch the identity, it means that it has expired.
            self.token = nil
        }
    }
}
