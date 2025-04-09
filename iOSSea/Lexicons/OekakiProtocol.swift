//
//  Oekaki.swift
//  iOSSea
//
//  Created by makrowave on 08/04/2025.
//

import SwiftUI

protocol OekakiResponseProtocol {
    var oekaki: [Post] { get }
}

protocol OekakiRequestProtocol {
    var since: String? { get set }
    var limit: Int? { get set }
}

class OekakiQueryWrapper<T: OekakiRequestProtocol>: ObservableObject {
    init(query: T) {
        self.query = query
    }
    @Published var query: T
    func setLimit(_ limit: Int?) -> Void {
        query.limit = limit
    }
    
    func setSince(_ since: String?) -> Void {
        query.since = since
    }
    
}
