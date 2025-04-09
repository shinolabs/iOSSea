//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

class GetRecentRequest : XrpcInvokable, OekakiRequestProtocol {
    
    var nsid = "com.shinolabs.pinksea.getRecent"
    
    var since: String?
    var limit: Int?
    init(since: String? = nil, limit: Int? = nil) {
        self.since = since
        self.limit = limit
    }
}

struct GetRecentResponse : Codable, OekakiResponseProtocol {
    let oekaki: [Post]
}
