//
//  PropertiesModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 31.12.2021.
//

import Foundation
import UIKit

struct PropertiesModel: Codable {
    let id: Int?
    let name: String?
    let manufacturer: String?
    let itemNumber: Int?
    let starting: Bool?
    let fuelType: String?
    let engineCapacity: Double?
    let transmissionType: String?
    let mileage: String?
    let endDate: String?
    let image: Data?
}
