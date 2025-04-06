//
//  XrpcError.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

final class XrpcError : Error, Codable {
    let error: String
    let message: String?
}
