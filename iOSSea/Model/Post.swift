//
//  Post.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import Foundation

struct Post {
    var tags: [String]
    var date: Date
    var author: Author
    var image: URL
}

struct Author {
    var did: String
    var handle: String
}
