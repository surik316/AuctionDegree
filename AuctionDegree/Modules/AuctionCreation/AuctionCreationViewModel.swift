//
//  AuctionCreationViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 03.01.2022.
//

import Foundation
import UIKit

protocol AuctionCreationViewModelProtocol {
    func createAuction(callback: (() -> Void)?)
    func loadModel(name: String,
                   manufacturer: String,
                   model: String,
                   year: String,
                   itemNumber: String,
                   starting: String,
                   fuelType: String,
                   engineCapacity: String,
                   transmissionType: String,
                   mileage: String,
                   endDate: String)
}

class AuctionCreationViewModel: AuctionCreationViewModelProtocol {
    
    var model: AuctionCreationModel?
    
    func loadModel(name: String,
                   manufacturer: String,
                   model: String,
                   year: String,
                   itemNumber: String,
                   starting: String,
                   fuelType: String,
                   engineCapacity: String,
                   transmissionType: String,
                   mileage: String,
                   endDate: String) {
        self.model = AuctionCreationModel(name: name,
                                     manufacturer: manufacturer,
                                     model: model,
                                     year: year,
                                     itemNumber: itemNumber,
                                     starting: starting,
                                     fuelType: fuelType,
                                     engineCapacity: engineCapacity,
                                     transmissionType: transmissionType,
                                     mileage: mileage,
                                     endDate: endDate)
    }
    func createAuction(callback: (() -> Void)?) {
        guard let dict = try? JSONSerialization.jsonObject(with: JSON.encoder.encode(model)) as? [String: String] else {
            return
        }
        NetworkEngine.request(endpoint: AuctionEndPoint.createAuction, bodyReq: dict) {  (result: Result<String, Error>) in
            switch result {
            case .success(let str):
                callback?()
                debugPrint("Created auction")
            case .failure(let failure):
                debugPrint("Error Created auction \(failure)")
            }
        }
    }
}
