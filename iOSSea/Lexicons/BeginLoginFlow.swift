//
//  BeginLoginFlow.swift
//  iOSSea
//
//  Created by nano on 06/04/2025.
//

struct BeginLoginFlowRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.beginLoginFlow"
    
    let handle : String
    let password : String?
    let redirectUrl : String
}

struct BeginLoginFlowResponse : Codable {
    let redirect : String
}
