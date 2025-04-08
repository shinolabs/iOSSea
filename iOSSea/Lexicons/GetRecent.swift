//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct GetRecentRequest : XrpcInvokable, OekakiRequestProtocol {
    init(since: String?, limit: Int?) {
        self.since = since
        self.limit = limit
    }
    
    var nsid = "com.shinolabs.pinksea.getRecent"
    
    let since: String?
    let limit: Int?
}

struct GetRecentResponse : Codable, OekakiResponseProtocol {
    let oekaki: [Post]
}
