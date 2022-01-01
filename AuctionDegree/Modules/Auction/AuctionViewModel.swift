//
//  AuctionViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation
import UIKit


final class AuctionViewModel: NSObject {
    private(set) var  model: AdditionalInfoModel?
    override init() {
        super.init()
        fetchData()
    }
    func fetchData() {
        let arr = [UIImage(named: "car"),
                   UIImage(named: "another"),
                   UIImage(named: "car"),
                   UIImage(named: "another")]
        model = AdditionalInfoModel(images: arr,
                                    isTurnOn: true,
                                    isWorking: true,
                                    id: "202020",
                                    fuel: "Бензин",
                                    engineCapacity: "128340123",
                                    typeCarBox: "Автомат",
                                    milage: "87192034",
                                    name: "Та еще дура",
                                    closeDate: "Some")
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

extension AuctionViewModel: UITableViewDelegate {
    
}
