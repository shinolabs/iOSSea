//
//  GetRecent.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

import Foundation

struct InvalidateSessionRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.invalidateSession"
}

struct InvalidateSessionResponse : Codable {
}
