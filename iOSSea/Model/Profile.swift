//
//  Profile.swift
//  iOSSea
//
//  Created by nano on 08/04/2025.
//

struct Profile : Codable {
    var did : String
    var handle : String
    var nickname : String
    var description : String
    var avatarUrl : String
    var links : [Link]
    
    init() {
        self.did = ""
        self.handle = ""
        self.nickname = ""
        self.description = ""
        self.avatarUrl = ""
        self.links = []
    }
    
    init(from: GetProfileResponse) {
        self.did = from.did
        self.handle = from.handle
        self.nickname = from.nick
        self.description = from.description
        self.avatarUrl = from.avatar
        self.links = from.links
    }
}

struct Link : Codable {
    var name : String
    var url : String
}
