//
//  EndpointError.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

final class EndpointError : Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}
