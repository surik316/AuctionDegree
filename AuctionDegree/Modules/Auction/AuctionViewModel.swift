//
//  AuctionViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation
import UIKit
enum TypeUpdateUI {
    case slotInfo
    case auctionMembers
}
protocol AuctionViewModelProtocol {
    func fetchData()
    var updateUI: ((TypeUpdateUI)-> Void)? { get set }
    var images: [UIImage?] { get }
    var model: [String: String] { get }
    var keys: [String] { get }
}
class AuctionViewModel: AuctionViewModelProtocol {
   
    var model = ["Заводится": "", "На ходу": "", "Топливо": "", "Объем двигателя": "", "Тип коробки": "", "Пробег": "", "Номер лота": ""]
    var keys = ["Заводится", "На ходу", "Топливо", "Объем двигателя", "Тип коробки", "Пробег", "Номер лота"]
    var images = [UIImage?]()
    var updateUI: ((TypeUpdateUI) -> Void)?
    init() {}
    func fetchData() {
        let arr =  [UIImage(named: "car"),
                    UIImage(named: "another"),
                    UIImage(named: "car"),
                    UIImage(named: "another")]
        let mv = AdditionalInfoModel(images: arr,
                                    isTurnOn: true,
                                    isWorking: true,
                                    id: "202020",
                                    fuel: "Бензин",
                                    engineCapacity: "128340123",
                                    typeCarBox: "Автомат",
                                    milage: "87192034",
                                    name: "Та еще дура",
                                    closeDate: "Some")
        model["Заводится"] = mv.isTurnOn ? "Да" : "Нет"
        model["На ходу"] = mv.isWorking ? "Да" : "Нет"
        model["Топливо"] = mv.fuel
        model["Объем двигателя"] = mv.engineCapacity
        model["Тип коробки"] = mv.typeCarBox
        model["Пробег"] = mv.milage
        model["Номер лота"] = mv.id
        images = mv.images
        updateUI?(.slotInfo)
    }
}

//extension AuctionViewModel: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//}

