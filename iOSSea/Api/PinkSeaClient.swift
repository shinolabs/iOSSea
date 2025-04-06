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
    
    func query<T: Decodable>(
        nsid: String,
        params: [URLQueryItem]
    ) async throws -> T {
        guard let finalUrl = URL(string: nsid, relativeTo: baseUrl)?.appending(queryItems: params) else {
            throw EndpointError(message: "Not a valid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: finalUrl)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw GenericClientError(message: "The resulting response is not a URL response")
        }
        
        guard httpResponse.statusCode == 200 else {
            do {
                let error = try JSONDecoder().decode(XrpcError.self, from: data)
                throw error
            } catch {
                throw GenericClientError(message: "An unprocessable error has occured while performing an XRPC call (url: \(finalUrl), code: \(httpResponse.statusCode)).")
            }
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
