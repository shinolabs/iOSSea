//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct GetRecentRequest : XrpcInvokable, OekakiRequestProtocol {
    var nsid = "com.shinolabs.pinksea.getRecent"
    
    var since: String?
    var limit: Int?
}

struct GetRecentResponse : Codable, OekakiResponseProtocol {
    let oekaki: [Post]
}
