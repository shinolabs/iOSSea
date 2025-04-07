//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct GetAuthorFeedRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.getAuthorFeed"
    var did: String
}

struct GetAuthorFeedResponse : Codable {
    let oekaki: [Post]
}
