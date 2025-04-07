//
//  GetIdentity.swift
//  iOSSea
//
//  Created by nano on 07/04/2025.
//

struct GetIdentityRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.getIdentity"
}

struct GetIdentityResponse : Codable {
    let did : String
    let handle : String
}
