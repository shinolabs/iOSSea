//
//  UploadEventManager.swift
//  iOSSea
//
//  Created by nano on 30/04/2025.
//

import Combine

final class UploadEventManager {
    static var shared = UploadEventManager()
    
    let uploadedEvent = PassthroughSubject<Post, Never>()
    
    private init() {
        
    }
    
    func sendUploadedEvent(_ post: Post) {
        uploadedEvent.send(post)
    }
}
