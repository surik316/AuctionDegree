//
//  PropertiesViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 31.12.2021.
//

import Foundation
import UIKit
protocol PropertiesViewModelProtocol {
    var propertiesArray: [PropertiesModel] {get}
    func fetchProperties(callback: (()->Void)?)
}
class PropertiesViewModel: PropertiesViewModelProtocol {
    
    var propertiesArray = [PropertiesModel]()
    
    func fetchProperties(callback: (()->Void)?) {
        NetworkEngine.request(endpoint: AuctionEndPoint.allItems, bodyReq: nil) {  (result: Result<[PropertiesModel], Error>) in
            switch result {
            case .success(let models):
                self.propertiesArray = models
                callback?()
                debugPrint("Models of properties recieved")
            case .failure(let failure):
                debugPrint("Load properties error \(failure)")
            }
        }
    }
}
