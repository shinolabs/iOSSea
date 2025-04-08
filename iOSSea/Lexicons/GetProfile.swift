//
//  GetProfile.swift
//  iOSSea
//
//  Created by nano on 08/04/2025.
//

struct GetProfileRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.unspecced.getProfile"
    
    let did : String
}

struct GetProfileResponse : Codable {
    let did : String
    let handle : String
    let nick : String
    let description : String
    let avatar : String
    let links : [Link]
}
