//
//  AuthenticationManager.swift
//  iOSSea
//
//  Created by nano on 07/04/2025.
//

import Combine
import KeychainSwift

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private let tokenKeychainKey = "pinksea_token"
    private init() {
        guard let storedToken = keychain.get(tokenKeychainKey) else {
            print("No token in keychain :(")
            return
        }
        
        print("Found token from keychain \(storedToken)")
        
        Task {
            await setToken(token: storedToken)
        }
    }
    
    private var token : String? = nil
    private var did : String? = nil
    
    let keychain = KeychainSwift()
    let eventSubject = PassthroughSubject<AuthenticationEvent, Never>()
    
    func loggedIn() -> Bool {
        return token != nil
    }
    
    func getDid() -> String? {
        return did
    }
    
    func getToken() -> String? {
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
        
        keychain.set(token, forKey: tokenKeychainKey)
    }
    
    func setIdentity() async {
        do {
            let identity : GetIdentityResponse = try await PinkSeaClient.shared.query(GetIdentityRequest())
            self.did = identity.did
            
            print("Received our identity, it's \(identity.did)")
        } catch {
            self.keychain.delete(tokenKeychainKey)
            self.token = nil
        }
    }
}
