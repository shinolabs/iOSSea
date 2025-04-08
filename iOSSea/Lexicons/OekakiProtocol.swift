//
//  Oekaki.swift
//  iOSSea
//
//  Created by makrowave on 08/04/2025.
//

protocol OekakiResponseProtocol {
    var oekaki: [Post] { get }
}

protocol OekakiRequestProtocol {
    var since: String? { get }
    var limit: Int? { get }
    init(since: String?, limit: Int?)
}
