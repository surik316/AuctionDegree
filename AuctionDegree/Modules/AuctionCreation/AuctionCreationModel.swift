//
//  AuctionCreationModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 03.01.2022.
//

import Foundation

struct AuctionCreationModel: Codable {
    let name: String
    let manufacturer: String
    let model: String
    let year: String
    let itemNumber: String
    let starting: String
    let fuelType: String
    let engineCapacity: String
    let transmissionType: String
    let mileage: String
    let endDate: String
}
