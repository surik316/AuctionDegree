//
//  UrlFactory.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation

enum CoronaEndPoint: UrlProtocol {
    case auth
    case registration
    var scheme: String {
        switch self {
        case .auth, .registration:
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
        case .registration:
            return "/reg/"
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case .auth, .registration:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .auth, .registration:
            return "POST"
        }
    }
}
