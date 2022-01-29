//
//  UserDefaults.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 29.01.2022.
//

import Foundation
import UIKit

extension UserDefaults {
    var userToken: String {
        get {
            return string(forKey: "App.UserToken") ?? ""
        }
        set {
            setValue(newValue, forKey: "App.UserToken")
        }
    }
}
