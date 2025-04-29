//
//  UploadOekaki.swift
//  iOSSea
//
//  Created by nano on 29/04/2025.
//

struct PutOekakiRequest : XrpcInvokable {
    var nsid = "com.shinolabs.pinksea.putOekaki"
    
    var data : String
    var tags : [String]?
    var alt : String?
    var parent : String?
    var nsfw : Bool?
    var bskyCrosspost : Bool?
}

struct PutOekakiResponse : Codable {
    var uri : String
    var rkey : String
}
