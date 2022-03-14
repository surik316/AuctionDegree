//
//  EditUserDataViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 21.02.2022.
//

import Foundation
import UIKit
protocol EditUserDataViewModelProtocol {
    func updateUserData(username: String?, image: UIImage?, callback: @escaping (() -> Void))
}
class EditUserDataViewModel: EditUserDataViewModelProtocol {
    
    func updateUserData(username: String?, image: UIImage?, callback: @escaping (() -> Void)) {
        
    }
}
