//
//  ProfileViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 02.01.2022.
//

import Foundation
import UIKit

class ProfileViewModel {
    private(set) var model: ProfileModel?
    
    
    func fetchModel() {
        model = ProfileModel(firstName: "Maksim", secondName: "Surkov", image: UIImage(named: "car")!)
    }
}
