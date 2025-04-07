//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct GetHandleFromDidRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.getHandleFromDid"
    var did: String
}

struct GetHandleFromDidResponse : Codable {
    let handle: String
}

