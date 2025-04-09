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

protocol OekakiRequestProtocol: ObservableObject {
    var since: String? { get set }
    var limit: Int? { get set }
}
