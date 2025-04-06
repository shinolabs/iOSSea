//
//  Post.swift
//  iOSSea
//
//  Created by makrowave on 05/04/2025.
//

import Foundation

struct Post: Codable {
    var tags: [String]
    var creationTime: String
    var author: Author
    var image: String
    var alt: String
    var nsfw: Bool
    var cid: String
    var at: String
    
    func getFormattedDate() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = inputFormatter.date(from: creationTime) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm:ss a"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.timeZone = TimeZone.current

        return outputFormatter.string(from: date)
    }
    func getUrl() -> URL {
        URL(string: image)!
    }
}

struct Author: Codable {
    var did: String
    var handle: String
}
