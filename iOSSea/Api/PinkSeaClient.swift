//
//  PinkSeaClient.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

final class PinkSeaClient {
    static let shared = PinkSeaClient()
    
    let baseUrl = URL(string: "https://api.pinksea.art/xrpc/")
    
    private init() {
        
    }
    
    func query<TRequest: XrpcInvokable, TResponse: Decodable>(
        _ data: TRequest
    ) async throws -> TResponse {
        let params = try data.toQueryItems()
        
        guard let finalUrl = URL(string: data.nsid, relativeTo: baseUrl)?.appending(queryItems: params) else {
            throw EndpointError(message: "Not a valid URL")
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "GET"

        if let token = AuthenticationManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw GenericClientError(message: "The resulting response is not a URL response")
        }
        
        guard httpResponse.statusCode == 200 else {
            let error : XrpcError
            do {
                error = try JSONDecoder().decode(XrpcError.self, from: data)
            } catch {
                throw GenericClientError(message: "An unprocessable error has occured while performing an XRPC call (url: \(finalUrl), code: \(httpResponse.statusCode)).")
            }
            
            throw error
        }
        
        return try JSONDecoder().decode(TResponse.self, from: data)
    }
    
    func procedure<TRequest: XrpcInvokable, TResponse: Decodable>(
        _ data: TRequest
    ) async throws -> TResponse {
        guard let finalUrl = URL(string: data.nsid, relativeTo: baseUrl) else {
            throw EndpointError(message: "Not a valid URL")
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = AuthenticationManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = try JSONEncoder().encode(data)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw GenericClientError(message: "The resulting response is not a URL response")
        }
        
        guard httpResponse.statusCode == 200 else {
            let error : XrpcError
            do {
                error = try JSONDecoder().decode(XrpcError.self, from: data)
            } catch {
                throw GenericClientError(message: "An unprocessable error has occured while performing an XRPC call (url: \(finalUrl), code: \(httpResponse.statusCode)).")
            }
            
            throw error
        }
        
        return try JSONDecoder().decode(TResponse.self, from: data)
    }
}
