//
//  GetSearchResults.swift
//  iOSSea
//
//  Created by makrowave on 18/04/2025.
//

import Foundation


struct GetSearchResultsRequest : XrpcInvokable, OekakiRequestProtocol {
    
    
    var nsid = "com.shinolabs.pinksea.getSearchResults"
    //https://api.pinksea.art/xrpc/com.shinolabs.pinksea.getTagFeed?tag=gaming
    var type: String
    var query: String
    
    var since: String?
    var limit: Int?
}

struct GetSearchResultsResponse : Codable, OekakiResponseProtocol {
    let oekaki: [Post]
    let tags: [TagResponse]
    let profiles: [Author]
}
