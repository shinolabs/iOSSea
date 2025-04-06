//
//  EncodableExtensions.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

extension Encodable {
    func toQueryItems() throws -> [URLQueryItem] {
        let data = try JSONEncoder().encode(self)
        
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return []
        }
        
        let queryItems = dict.map { (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: "\(value)")
        }
        
        return queryItems
    }
}
