//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct GetParentForReplyRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.getParentForReply"
    
    var did: String
    var rkey: String
}

struct GetParentForReplyResponse : Codable {
    let did: String
    let rkey: String
}
