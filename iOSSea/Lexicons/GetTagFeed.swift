//
//  Tags.swift
//  iOSSea
//
//  Created by makrowave on 18/04/2025.
//

import Foundation


struct GetTagFeedRequest : XrpcInvokable, OekakiRequestProtocol {
    
    
    var nsid = "com.shinolabs.pinksea.getTagFeed"
    var tag: String
    
    var since: String?
    var limit: Int?
}

struct GetTagFeedResponse : Codable, OekakiResponseProtocol {
    let oekaki: [Post]
}
