//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct GetAuthorRepliesRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.getAuthorReplies"
    var did: String
}

struct GetAuthorRepliesResponse : Codable {
    let oekaki: [Post]
}
