//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct GetOekakiRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.getOekaki"
    
    var did: String
    var rkey: String
}

struct GetOekakiResponse : Codable {
    let parent: Post
    let children: [Post]
}
