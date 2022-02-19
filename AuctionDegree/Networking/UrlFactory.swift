//
//  UrlFactory.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation

enum AuctionEndPoint: UrlProtocol {
    case auth
    case registration
    case createAuction
    case allItems
    var scheme: String {
        switch self {
        case .auth, .registration, .allItems, .createAuction:
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
        case .createAuction:
            return "/item/new/"
        case .allItems:
            return "/item/getAll/"
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case .auth, .registration, .createAuction, .allItems:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .auth, .registration, .createAuction:
            return "POST"
        case .allItems:
            return "GET"
        }
    }
}
