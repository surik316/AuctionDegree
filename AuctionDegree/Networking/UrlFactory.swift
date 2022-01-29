//
//  UrlFactory.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation

enum CoronaEndPoint: UrlProtocol {
    case auth
    var scheme: String {
        switch self {
        case .auth:
            return "http"
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "178.20.45.246"
        }
    }
    var path: String {
        switch self {
        case .auth:
            return "/auth/"
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case .auth:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .auth:
            return "POST"
        }
    }
}
