//
//  UrlFactory.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation

enum CoronaEndPoint: UrlProtocol {
    case getCountryData(name: String)
    case getStateData(name: String)
    case getWorldData
    case getOtherCountriesData
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "corona.lmao.ninja"
        }
    }
    var path: String {
        switch self {
        case .getCountryData(let name):
            return "/v2/countries/\(name)"
        case .getStateData(let name):
            return "/v2/states/\(name)"
        case .getWorldData:
            return "/v2/all"
        case .getOtherCountriesData:
            return "/v2/countries"
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case .getCountryData:
            return [URLQueryItem(name: "yesterday", value: nil),
                    URLQueryItem(name: "strict", value: nil),
                    URLQueryItem(name: "query%20", value: nil)]
        case .getStateData, .getWorldData:
            return [URLQueryItem(name: "yesterday", value: nil)]
        case .getOtherCountriesData:
            return [URLQueryItem(name: "yesterday", value: nil),
                    URLQueryItem(name: "sort", value: nil)]
        }
    }
    
    var method: String {
        switch self {
        case .getCountryData, .getStateData,.getWorldData, .getOtherCountriesData:
            return "GET"
        }
    }
}
