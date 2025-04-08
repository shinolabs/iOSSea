//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct GetRecentRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.getRecent"
    
    let since: String?
    let limit: Int?
}

struct GetRecentResponse : Codable {
    let oekaki: [Post]
}
